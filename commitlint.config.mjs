export default {
  extends: ["@commitlint/config-conventional"],
  ignores: [
    (msg) => /Signed-off-by: dependabot\[bot]/m.test(msg),
    (msg) => /^\w+\(deps\): bump .+ from .+ to .+/.test(msg),
    // scripts/bump.sh writes these; squash-merging one adds GitHub's
    // Co-authored-by trailer for the release bot, which is over 100 characters.
    (msg) => /^chore\((cask|formula)\): bump \S+ to \S+/.test(msg),
  ],
};
