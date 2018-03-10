# Introduction

# About the Repository
The repository can be found at https://github.com/zephinzer/version-tagging-scripts, and it provides for versioning operations that are run in an automated continuous integration/delivery pipeline.

# Why do we Version
When I first became a professional developer, one thing I wasn't used to was versioning.

In any ways, didn't Git provide the necessary versioning capabilities to rollback to a certain copy of the code?

Well apparently not.

## Code Snapshot
Code is dynamic, it changes as developers push new features and implement bug fixes. How do we identify an exact copy of the code? This is what versioning is meant for.

Git itself is a system to manage versioning of the code, but it does this in a way that isn't friendly to normal humans - a commit hash. This looks something like: `a3c677046c5b8abec75015773f40743f81a6575c`.

## Human Communication
So instead of referring to versions of the code with *"the one that starts with a, three, c, six, seven..."*, we created this thing called SEMVER - semantic versioning.

Semantic versioning provides an easier way to communicate versions, and it looks like `1.10.3`, `3.9.15` *et cetera*.

The first number is called the major version and changes in this number represents new features with non-backward compatibility.

The second number is called the minor version and changes in this number represents new features with backward compatibility.

The last number is called the patch version and changes in this number in general represents non-behaviour altering changes such as bug fixes.

When a bug is found, users (both non-techies - for products, and developers - for open-source packages) generally report them to developers.

When this happens, the version becomes important because it's human friendly.

Think *"I'm using version 1.0.3 and when I do (x), (y) happens, which is unexpected."*

## Automation

### Dependency Management
Look at the `package.json` of any Node project and you'll find that in the `"dependencies"` property, each dependency package has a version associated with it that looks like:

- `~1.0.0`
- `^2.3.1`
- `0.3.7`

Proper versioning allows us to identify what level of change is permissible for dependencies in our code base.

The tilda (`~`) indicates that if the remote package has a patch version upgrade, update the local copy too.

The caret (`^`) indicates that if the remote package has a minor version upgrade, update the local copy too.

The last but rarely seen way of listing a dependency is:

- `*`

This indicates to always use the latest version whatever it may be.

### Continuous Integration/Delivery
When you have a team size of roughly 10 developers and upward, multiple pushes of code happen every day and we often need to find a working copy of the code.

Versioning allows us to identify the copy of the code which works. When all tests pass, we bump the version and tag it to the commit (a version of the code according to Git).

# How Versioning is Implemented

## File Based
Run the script `./scripts/bump-version-file.sh`. This initialises a `.version` file with `0.0.0`

File-based versioning is fine for individual developers. But as your team scales, this creates a problem especially when an automatic continuous integration/delivery pipeline is present.

Since the versioning is done by the pipeline, when two or more developers push the code together, this results in a merge conflict since bumping the version requires a commit to be made in the pipeline.

## Git Tag Based
To resolve the problem of merge conflcits in the pipeline, we use Git tags to implement versioning.

Git tags exist independently of the files in the repository and are associated with a commit.

Pushing of a Git tag is done using `git push --tags` and can be fetched using `git fetch` without causing any file changes.

The `version-tagging-scripts` repository was made for this purpose.

# Using the Scripts

The repository allows for the following actions:

**Initialise**
This checks for any Git tags with a SEMVER format. If there exists one, nothing is done. If there isn't an existing SEMVER tag, this script will add a new `0.0.0` Git tag.

> Command: `init`

**Iterate**
This iterates to the next version and takes an argument of `patch`, `minor` or `major`. The default if no SEMVER selector is indicated is `patch`:

> Command: `iterate [{patch, minor, major}]`

## Manual Inclusion

Download the zip file into your application directory and unzip it:

```bash
mkdir -p ./scripts \
  && curl -o ./scripts/vtscripts.zip -sSL https://github.com/zephinzer/version-tagging-scripts/archive/master.zip \
  && unzip ./scripts/vtscripts.zip -d ./scripts/vtscripts \
  && mv ./scripts/vtscripts/*/* ./scripts/vtscripts \
  && mv ./scripts/vtscripts/*/.* ./scripts/vtscripts \
  && rm -rf ./scripts/vtscripts/version-tagging-scripts-master;
```

## Via Gitsubmodules

Inside your Git repository, run the following to initialise and use the repository as a Git submodule:

```bash
mkdir -p ./scripts \
  && git submodule init \
  && git submodule add https://github.com/zephinzer/version-tagging-scripts/ ./scripts/vtscripts
```

From a clone of the Git repository, run the following to retrieve the submodule:

```bash
git submodule sync \
  && git submodule update --init --remote
```

To completely remove the Git submodule, run:

```bash
git rm -f "scripts/vtscripts" \
  && rm -rf ".git/modules/scripts/vtscripts" \
  && git config -f .git/config --remove-section "submodule.scripts/vtscripts";
```

## Via Docker

This tool is also available as a Docker image.

Run the following to use the Docker image to initialise a repository for versioning (sets up a `0.0.0` tag):

```bash
docker run -v "$(pwd):/app" zephinzer/vtscripts:latest init;
```

To bump the patch version:

```bash
docker run -v "$(pwd):/app" zephinzer/vtscripts:latest iterate patch;
```

To bump the minor version:

```bash
docker run -v "$(pwd):/app" zephinzer/vtscripts:latest iterate minor;
```

To bump the major version:

```bash
docker run -v "$(pwd):/app" zephinzer/vtscripts:latest iterate major;
```

# Takeaways

- version for human communication
- versioning your code saves lives
- favour tags over commits for ease of team scaling