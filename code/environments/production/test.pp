exec {
  "${name} unmanaged program install":
    cwd     => $executable_file_location,
    command => "cmd /c \" ${executable_file_name} ${install_options} \"",
    onlyif  =>
      [
        "cmd /c \" java -jar check.jar --ini-file --section \"unmanaged\" --setting \"${name}\" --not-equal \"1\" \"",
        "powershell -Command If (Test-Path -Path ${executable_file_location}) {exit 0;} else {exit 1;}"
      ],
    alias   => "$name-install"
}








