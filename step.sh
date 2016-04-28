#!/bin/bash

# Configs
echo ""
echo "========== Configs =========="
if [[ -n "${fauxpas_license_type}" ]]; then
	echo "fauxpas_license_type: ************"
else
	echo "fauxpas_license_type: this is required"
	exit 1
fi
if [[ -n "${fauxpas_license_name}" ]]; then
	echo "fauxpas_license_name: ************"
else
	echo "fauxpas_license_name: this is required"
	exit 1
fi
if [[ -n "${fauxpas_license_key}" ]]; then
	echo "fauxpas_license_key: ************"
else
	echo "fauxpas_license_key: this is required"
	exit 1
fi
if [[ -n "${LOGNAME}" ]]; then
	echo "Logname: ${LOGNAME}"
fi
if [[ -n "${fauxpas_debug_mode}" ]]; then
	echo "fauxpas_debug_mode: ${fauxpas_debug_mode}"
fi
if [[ -n "${BITRISE_SOURCE_DIR}" ]]; then
	echo "BITRISE_SOURCE_DIR: ${BITRISE_SOURCE_DIR}"
fi
if [[ -n "${fauxpas_partial_custom_config}" ]]; then
	echo "fauxpas_partial_custom_config: ${fauxpas_partial_custom_config}"
fi
if [[ -n "${fauxpas_project_path}" ]]; then
	echo "fauxpas_project_path: ${fauxpas_project_path}"
fi
if [[ -n "${fauxpas_workspace_path}" ]]; then
	echo "fauxpas_workspace_path: ${fauxpas_workspace_path}"
fi
if [[ -n "${fauxpas_target}" ]]; then
	echo "fauxpas_target: ${fauxpas_target}"
fi
if [[ -n "${fauxpas_scheme}" ]]; then
	echo "fauxpas_scheme: ${fauxpas_scheme}"
fi
if [[ -n "${fauxpas_build_config}" ]]; then
	echo "fauxpas_build_config: ${fauxpas_build_config}"
fi
echo "============================="
echo ""

# Variable verification
execute_mode=""
if [[ -n "${fauxpas_target}" ]]; then
	execute_mode=" -t ${fauxpas_target}"
elif [[ -n "${fauxpas_scheme}" ]]; then
	execute_mode=" --workspace ${fauxpas_workspace_path} --scheme ${fauxpas_scheme}"
else
	echo "Defining fauxpas_scheme OR fauxpas_target is required."
	exit 1
fi

if [[ "${fauxpas_debug_mode}" = true ]]; then
	set -x
fi

# go to project folder
cd "${BITRISE_SOURCE_DIR}"

# Install FauxPas
brew cask install fauxpas

# Install FauxPas CLI
/Users/${LOGNAME}/Applications/FauxPas.app/Contents/Resources/install-cli-tools

# Install FauxPas license
if [[ "${fauxpas_debug_mode}" = true ]]; then
	set +x
fi
fauxpas updatelicense "${fauxpas_license_type}" "${fauxpas_license_name}" "${fauxpas_license_key}"
if [[ "${fauxpas_debug_mode}" = true ]]; then
	set -x
fi

build_config=""
if [[ -n "${fauxpas_build_config}" ]]; then
	build_config=" -b \"${fauxpas_build_config}\""
fi

# Execute FauxPas
fauxpas check "${fauxpas_project_path}" $execute_mode $build_config ${fauxpas_partial_custom_config} -o json > fauxpas_output.json

export FAUXPAS_OUTPUT_FILE="$PWD/fauxpas_output.json"
envman add --key FAUXPAS_OUTPUT_FILE --value "$PWD/fauxpas_output.json"

echo ""
echo "========== Outputs =========="
echo "FAUXPAS_OUTPUT_FILE: ${FAUXPAS_OUTPUT_FILE}"
echo "============================="
echo ""

if [[ "${fauxpas_debug_mode}" = true ]]; then
	cat ${FAUXPAS_OUTPUT_FILE}
fi

exit 0
