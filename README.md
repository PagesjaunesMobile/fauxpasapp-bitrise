# FauxPas Check

This step will use [Faux Pas](http://fauxpasapp.com) in order to check your iOS code.

# How to use it

Modify your `bitrise.yml` in order to test it.

For an app that works with a workspace.

```yaml
    - git::https://github.com/PagesjaunesMobile/fauxpasapp-bitrise.git@master:
        inputs:
        - fauxpas_license_type: Set the type in the license between these personal,organization-seat,site and enterprise
        - fauxpas_scheme: $BITRISE_SCHEME
        - fauxpas_project_path: pathToYour.xcodeproj
        - fauxpas_workspace_path: pathToYour.xcworkspace
        - fauxpas_build_config: buildConfiguration
        - fauxpas_partial_custom_config: If you want to append some custom param to faux pas
        - fauxpas_debug_mode: Set it to true or false in order to use it
```

For an app that works with an xcodeproj.
```yaml
    - git::https://github.com/PagesjaunesMobile/fauxpasapp-bitrise.git@master:
        inputs:
        - fauxpas_license_type: Set the type in the license between these personal,organization-seat,site and enterprise
        - fauxpas_target: targetName
        - fauxpas_project_path: pathToYour.xcodeproj
        - fauxpas_build_config: buildConfiguration
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

# Changelog

* 1.0.0

  * Install, configure and start Faux Pas
  * Check the code of a project
  * Export the result of the analysis in JSON
