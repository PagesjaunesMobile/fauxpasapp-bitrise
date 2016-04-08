# FauxPas Check

This step will use [Faux Pas](http://fauxpasapp.com) in order to check your iOS code.

# How to use it

Modify your `bitrise.yml` in order to test it.

For an app that works with a workspace.

```yaml
    - git::https://github.com/mackoj/fauxpasapp-bitrise.git@master:
        inputs:
        - fauxpas_license_type: Set the type in the license between these personal,organization-seat,site and enterprise
        - fauxpas_scheme: $BITRISE_SCHEME
        - fauxpas_project_path: pathToYour.xcodeproj
        - fauxpas_build_config: buildConfiguration
        - fauxpas_build_config: Debug
        - fauxpas_source_dir: $BITRISE_SOURCE_DIR
        - fauxpas_partial_custom_config: If you want to append some custom param to faux pas
        - fauxpas_debug_mode: Set it to true or false in order to use it
```

For an app that works with an xcodeproj.
```yaml
    - git::https://github.com/mackoj/fauxpasapp-bitrise.git@master:
        inputs:
        - fauxpas_license_type: Set the type in the license between these personal,organization-seat,site and enterprise
        - fauxpas_target: targetName
        - fauxpas_build_config: buildConfiguration
        - fauxpas_build_config: Debug
        - fauxpas_source_dir: $BITRISE_SOURCE_DIR
        - fauxpas_partial_custom_config: If you want to append some custom param to faux pas
        - fauxpas_debug_mode: Set it to true or false in order to use it
```

Add this to your secrets variable in order to test it.

```yaml
  - FAUXPAS_LICENSE_NAME: Set the name of the license
  - FAUXPAS_LICENSE_KEY: Set the Key in the license
```

# To Do

- Support for generating better report with [fauxpas-web-presenter](https://github.com/FauxPasApp/fauxpas-web-presenter) for the web report
- Improve Documentation
- Share in [bitrise-steplib](https://github.com/bitrise-io/bitrise-steplib)
- Open it to third-party developer

# Milestone

* 0.1.0

  * Support for workspace / xcodeproj
  * Documentation
  * Share with the community

* 0.2.0

  * Improved Documentation
  * Support for generating better report with [fauxpas-web-presenter](https://github.com/FauxPasApp/fauxpas-web-presenter) for the web report
  * Allow third-party developer to help
