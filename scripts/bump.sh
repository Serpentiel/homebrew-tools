#!/usr/bin/env bash
#
# Opens pull requests bumping the formula and cask to a released version.
#
# It downloads the published artifacts, computes their checksums, and edits the
# formula/cask in place — so it works with a GitHub App token (no fork needed,
# unlike `brew bump-*-pr`). Each target gets its own branch and PR off `main`,
# so nothing on `main` is touched until a PR is reviewed and merged.
#
# Usage: scripts/bump.sh <version>          # e.g. 4.0.0 (no leading v)
#
# Environment:
#   GH_TOKEN   GitHub App token used by `gh` and the `origin` remote.
#   APP_SLUG   App slug, used to attribute the bump commits to the bot.
#   DRY_RUN=1  Edit files in place and print the diff; never branch/commit/push.
set -euo pipefail

version="${1:?usage: bump.sh <version>}"
tag="v${version}"
branch_base="main"
base="origin/${branch_base}"
dry_run="${DRY_RUN:-}"

configure_identity() {
	[ -n "$dry_run" ] && return 0

	local slug="${APP_SLUG:?APP_SLUG is required}"
	local uid
	uid="$(gh api "/users/${slug}[bot]" --jq .id)"

	git config user.name "${slug}[bot]"
	git config user.email "${uid}+${slug}[bot]@users.noreply.github.com"
}

# sha256_of downloads a URL and prints its SHA-256 hex digest.
sha256_of() {
	local tmp
	tmp="$(mktemp)"
	curl -fsSL "$1" -o "$tmp"
	shasum -a 256 "$tmp" | awk '{ print $1 }'
}

# replace_field rewrites the single `  <field> "..."` line in a file. Values are
# passed via the environment so URLs and digests need no shell/sed escaping.
replace_field() {
	local file="$1" field="$2" value="$3"
	BUMP_FIELD="$field" BUMP_VALUE="$value" ruby -i -pe \
		'$_.sub!(/^(\s*#{Regexp.escape(ENV.fetch("BUMP_FIELD"))} ")[^"]*(")/) { "#{$1}#{ENV.fetch("BUMP_VALUE")}#{$2}" }' \
		"$file"
}

# submit edits a file on its own branch and opens (or updates) a PR off main.
# field/value arguments after the title are applied with replace_field.
submit() {
	local branch="$1" title="$2" file="$3"
	shift 3

	[ -n "$dry_run" ] || git checkout -q -B "$branch" "$base"

	while [ "$#" -gt 0 ]; do
		replace_field "$file" "$1" "$2"
		shift 2
	done

	git add "$file"
	if git diff --cached --quiet; then
		echo "no change for: $title"
		return 0
	fi

	if [ -n "$dry_run" ]; then
		echo "== [dry-run] ${title} =="
		git --no-pager diff --cached -- "$file"
		git restore --staged "$file"
		git checkout -- "$file"
		return 0
	fi

	git commit -q -m "$title"
	git push -q --force-with-lease origin "$branch"
	gh pr create --base "$branch_base" --head "$branch" --title "$title" \
		--body "Automated release bump to ${version}." 2>/dev/null ||
		gh pr edit "$branch" --title "$title" --body "Automated release bump to ${version}."
}

git fetch -q origin "$branch_base"
configure_identity

formula_url="https://github.com/Serpentiel/betterglobekey/archive/refs/tags/${tag}.tar.gz"
submit "bump-betterglobekey-${version}" \
	"chore(formula): bump betterglobekey to ${version}" \
	"Formula/betterglobekey.rb" \
	url "$formula_url" \
	sha256 "$(sha256_of "$formula_url")"

cask_url="https://github.com/Serpentiel/betterglobekey/releases/download/${tag}/betterglobekey-companion-${version}-universal.zip"
submit "bump-betterglobekey-companion-${version}" \
	"chore(cask): bump betterglobekey-companion to ${version}" \
	"Casks/betterglobekey-companion.rb" \
	version "$version" \
	sha256 "$(sha256_of "$cask_url")"
