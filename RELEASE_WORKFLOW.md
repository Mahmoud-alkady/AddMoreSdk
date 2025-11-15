# Release Workflow Guide

This document outlines the step-by-step process for releasing new versions of AdMoreSdk.

## Version Numbering

We follow [Semantic Versioning](https://semver.org/):
- **MAJOR.MINOR.PATCH** (e.g., `1.2.3`)
- **MAJOR**: Breaking changes
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, backward compatible

## Pre-Release Checklist

Before creating a release, ensure:

- [ ] All tests pass
- [ ] Framework builds successfully for all architectures
- [ ] Documentation is updated (README.md, CHANGELOG.md)
- [ ] Version number is updated in:
  - [ ] `VERSION` file
  - [ ] `Package.swift` (comment)
  - [ ] `CHANGELOG.md`
- [ ] No breaking changes (or clearly documented if breaking)
- [ ] iOS compatibility is verified and documented

## Release Steps

### Step 1: Update Version Files

1. Update `VERSION` file with new version number:
   ```
   1.2.3
   ```

2. Update `Package.swift` comment:
   ```swift
   // Version: 1.2.3
   ```

3. Update `CHANGELOG.md`:
   - Move items from `[Unreleased]` to new version section
   - Add release date
   - Update links at bottom

### Step 2: Update Documentation

1. Update `README.md` if needed:
   - Version compatibility table
   - New features documentation
   - Migration guides (if breaking changes)

2. Ensure installation instructions are current

### Step 3: Commit Changes

```bash
git add .
git commit -m "Release version 1.2.3"
```

### Step 4: Create Git Tag

```bash
# Create annotated tag (recommended)
git tag -a 1.2.3 -m "Release version 1.2.3"

# Or create lightweight tag
git tag 1.2.3
```

### Step 5: Push to Remote

```bash
# Push commits
git push origin main

# Push tags
git push origin 1.2.3

# Or push all tags
git push origin --tags
```

### Step 6: Create GitHub Release (Recommended)

1. Go to GitHub repository
2. Click **Releases** → **Draft a new release**
3. **Tag**: Select the tag you just created (e.g., `1.2.3`)
4. **Title**: `Version 1.2.3` or descriptive title
5. **Description**: Copy from CHANGELOG.md for this version
6. **Attach binaries** (if distributing separately)
7. Click **Publish release**

## Example Release Workflow

### Example: Releasing Version 1.1.0

```bash
# 1. Update version files
echo "1.1.0" > VERSION

# 2. Update Package.swift comment
# Edit: // Version: 1.1.0

# 3. Update CHANGELOG.md
# Move [Unreleased] items to [1.1.0] section

# 4. Commit
git add .
git commit -m "Release version 1.1.0 - iOS 13 support"

# 5. Tag
git tag -a 1.1.0 -m "Release version 1.1.0 - iOS 13 support"

# 6. Push
git push origin main
git push origin 1.1.0
```

### Example: Releasing Version 2.0.0 (Breaking Changes)

```bash
# 1. Update version files
echo "2.0.0" > VERSION

# 2. Update Package.swift
# - Update version comment
# - Update minimum iOS if needed
# - Update any breaking API changes

# 3. Update CHANGELOG.md
# - Add migration guide section
# - Document all breaking changes

# 4. Update README.md
# - Add migration guide
# - Update compatibility table

# 5. Commit
git add .
git commit -m "Release version 2.0.0 - Breaking changes, iOS 14+"

# 6. Tag
git tag -a 2.0.0 -m "Release version 2.0.0 - Breaking changes"

# 7. Push
git push origin main
git push origin 2.0.0
```

## Version Compatibility Management

### Updating Minimum iOS Version

If a new version requires a higher iOS version:

1. Update `Package.swift`:
   ```swift
   platforms: [
       .iOS(.v13)  // Changed from .v12
   ]
   ```

2. Update `README.md` compatibility table

3. Document in `CHANGELOG.md`

4. Consider maintaining backward compatibility if possible

## Hotfix Releases

For urgent bug fixes:

1. Create hotfix branch from latest release tag
2. Fix the issue
3. Increment PATCH version (e.g., `1.1.0` → `1.1.1`)
4. Follow normal release process
5. Merge back to main

## Branch Strategy

- **main**: Production-ready code, all releases tagged here
- **develop**: Development branch (optional)
- **feature/***: Feature branches
- **hotfix/***: Hotfix branches

## Verification After Release

After releasing, verify:

- [ ] Tag exists on GitHub
- [ ] GitHub release created (if applicable)
- [ ] Package resolves correctly via SPM
- [ ] Version appears in Xcode package manager
- [ ] Documentation is accessible

## Troubleshooting

### Tag Already Exists

If tag already exists locally:
```bash
git tag -d 1.2.3  # Delete local tag
git push origin :refs/tags/1.2.3  # Delete remote tag
# Then create new tag
```

### Wrong Version Committed

If you need to fix a version:
```bash
# Make corrections
git commit --amend -m "Release version 1.2.3"
git push origin main --force  # Use with caution
```

## Best Practices

1. **Always test before releasing** - Build and test the framework
2. **Document changes** - Update CHANGELOG.md for every release
3. **Use annotated tags** - Include meaningful messages
4. **Create GitHub releases** - Makes it easier for users to see what's new
5. **Maintain compatibility table** - Keep README.md updated
6. **Follow semantic versioning** - Don't break APIs in MINOR/PATCH releases

## Quick Reference

```bash
# Create and push release
git add .
git commit -m "Release version X.Y.Z"
git tag -a X.Y.Z -m "Release version X.Y.Z"
git push origin main
git push origin X.Y.Z
```

