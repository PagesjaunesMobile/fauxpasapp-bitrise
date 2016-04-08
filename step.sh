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
if [[ -n "${fauxpas_scheme}" ]]; then
	execute_mode=" --workspace ${fauxpas_project_path} --scheme ${fauxpas_scheme}"
elif [[ -n "${fauxpas_target}" ]]; then
	execute_mode=" -t \"${fauxpas_target}\""
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

# # Generate Report
# set -x
# echo "Salut Cyril 😎" > toto.txt
# tar cvfj report.html.tar.bz2 toto.txt
# touch "$PWD/report.html.tar.bz2"
#
# export FAUXPAS_MAIL_ATTACHMENT_FILE="$PWD/report.html.tar.bz2"
# export FAUXPAS_MAIL_HTML_HEAD_CONTENT="<script src=\"https://code.highcharts.com/highcharts.js\"></script>
# <script src=\"https://code.highcharts.com/modules/exporting.js\"></script>"
# export FAUXPAS_MAIL_HTML_BODY_CONTENT="<div id=\"container\" style=\"min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto\"></div><script>$(function(){$("#container").highcharts({chart:{plotBackgroundColor:null,plotBorderWidth:null,plotShadow:!1,type:"pie"},title:{text:"Browser market shares January, 2015 to May, 2015"},tooltip:{pointFormat:"{series.name}: <b>{point.percentage:.1f}%</b>"},plotOptions:{pie:{allowPointSelect:!0,cursor:"pointer",dataLabels:{enabled:!0,format:"<b>{point.name}</b>: {point.percentage:.1f} %",style:{color:Highcharts.theme&&Highcharts.theme.contrastTextColor||"black"}}}},series:[{name:"Brands",colorByPoint:!0,data:[{name:"Microsoft Internet Explorer",y:56.33},{name:"Chrome",y:24.03,sliced:!0,selected:!0},{name:"Firefox",y:10.38},{name:"Safari",y:4.77},{name:"Opera",y:.91},{name:"Proprietary or Undetectable",y:.2}]}]})});</script>"
#
# echo ""
# echo "========== Outputs =========="
# echo "FAUXPAS_OUTPUT_FILE: ${FAUXPAS_OUTPUT_FILE}"
# echo "FAUXPAS_MAIL_ATTACHMENT_FILE: ${FAUXPAS_MAIL_ATTACHMENT_FILE}"
# echo "FAUXPAS_MAIL_HTML_HEAD_CONTENT: ${FAUXPAS_MAIL_HTML_HEAD_CONTENT}"
# echo "FAUXPAS_MAIL_HTML_BODY_CONTENT: ${FAUXPAS_MAIL_HTML_BODY_CONTENT}"
# echo "============================="
# echo ""

exit 0
