# Dependency Dangers Example

## Premise
Major versions are for breaking changes.

Minor versions are for new features with backward compatibility.

Patch versions are for bug fixes/refactors with backward compatibility.

## Exercise
Let's see what happens when we don't take care of our versioning.

Observe the `package.json` file from the repositories `dependent-*` and note the dependency `juniordev-gitversioning-dependency`:

1. `*-star`: `*`
2. `*-caret`: `^5.0.0`
3. `*-tilda`: `~5.0.0`

### Observe the Dependency Versions
Run the following script to retrieve all the remote versions of the dependency:

```bash
./show-dependencies.sh
```

We'll be starting from `5.0.0`.

### Install the Dependencies
Observe the `package.json` in the dependent directories, note that in `dependent-caret`, the dependency version is `^5.0.0`, in `dependent-tilda`, the dependency version is `~5.0.0` and in `dependent-star`, the dependency version is `*`.

Run the script to do an `npm install` in all the dependents' directories:

```bash
./update-dependents.sh
```

### View the Installed Dependencies
Observe the versions of the installed `juniordev-gitversioning-dependency` dependency via:

```bash
./view-dependencies.sh
```

### Run the Tests
Observe that all dependent directories contain the same set of tests. This is so we can verify when behaviour has changed. Run the convenience script to run tests in all the dependent projects:

```
./test-dependencies.sh
```