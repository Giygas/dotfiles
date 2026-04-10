{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "segments": [
        {
          "foreground": "$color3",
          "style": "diamond",
          "template": "{{ round .PhysicalPercentUsed .Precision }}% ",
          "type": "sysinfo"
        },
        {
          "foreground": "$color3",
          "style": "diamond",
          "template": "{{ (div ((sub .PhysicalTotalMemory .PhysicalAvailableMemory)|float64) 1073741824.0) }}/{{ (div .PhysicalTotalMemory 1073741824.0) }}GB ",
          "type": "sysinfo"
        }
      ],
      "type": "rprompt"
    },
    {
      "alignment": "left",
      "segments": [
        {
          "foreground": "$color4",
          "options": {
            "macos": "mac"
          },
          "style": "plain",
          "template": "{{ if .WSL }}WSL at {{ end }}{{.Icon}} ",
          "type": "os"
        },
        {
          "foreground": "$color5",
          "style": "plain",
          "template": "in {{ .Value }} ",
          "type": "envvar",
          "properties": {
            "var": "DISTROBOX_NAME"
          }
        },
        {
          "foreground": "$color4",
          "style": "plain",
          "template": "$",
          "type": "text"
        },
        {
          "foreground": "$color4",
          "style": "plain",
          "template": "{{ .UserName }}:",
          "type": "session"
        },
        {
          "foreground": "$color7",
          "options": {
            "folder_separator_icon": "/",
            "style": "full"
          },
          "style": "plain",
          "type": "path"
        },
        {
          "foreground": "$color6",
          "foreground_templates": [
            "{{ if or (.Working.Changed) (.Staging.Changed) }}$color1{{ end }}",
            "{{ if and (gt .Ahead 0) (gt .Behind 0) }}$color4{{ end }}",
            "{{ if gt .Ahead 0 }}$color5{{ end }}",
            "{{ if gt .Behind 0 }}$color1{{ end }}"
          ],
          "options": {
            "branch_template": "{{ trunc 25 .Branch }}",
            "fetch_status": true,
            "fetch_upstream_icon": true
          },
          "style": "plain",
          "template": "<$color3>on</> {{.UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} \uf046 {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
          "type": "git"
        },
        {
          "foreground": "$color3",
          "style": "plain",
          "template": "\u276f ",
          "type": "text"
        }
      ],
      "type": "prompt"
    }
  ],
  "version": 4
}
