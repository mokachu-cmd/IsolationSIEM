[Setup]
AppName=IsolationSIEM
AppVersion=1.0.0
AppPublisher=Trinary Projects
DefaultDirName={commonpf64}\IsolationSIEM
DefaultGroupName=IsolationSIEM
OutputBaseFilename=IsolationSIEM_Platform_Setup
Compression=lzma2/max
SolidCompression=yes
SetupLogging=yes

; Security Configuration: Disables uninstallation interface and hides from Control Panel
ArchitecturesInstallIn64BitMode=x64
CreateAppDir=yes
Uninstallable=yes

[Files]
; 1. Stage custom binaries into the 'bin' folder
Source: "C:\IsolationSIEM\bin\servy-cli.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\IsolationSIEM\bin\producer.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\IsolationSIEM\bin\processor.exe"; DestDir: "{app}\bin"; Flags: ignoreversion

; 2. Recursively vacuum up the entire vendor tree (Elasticsearch, Kafka, Kibana, Ollama + heavy models)
Source: "C:\IsolationSIEM\vendor\*"; DestDir: "{app}\vendor"; Flags: ignoreversion recursesubdirs createallsubdirs

[Registry]
; Enterprise Stealth: Force-inject the System Component flag into the Windows Uninstall Registry.
; This completely hides the installation footprint from "Apps & Features" / Control Panel.
Root: HKLM64; Subkey: "Software\Microsoft\Windows\CurrentVersion\Uninstall\IsolationSIEM_is1"; ValueType: dword; ValueName: "SystemComponent"; ValueData: 1; Flags: noerror

[Run]
; Updated quote tokenization to handle complex characters safely
Filename: "{app}\bin\servy-cli.exe"; Parameters: "install --name=""IsolationSIEM-Elasticsearch"" --path=""{app}\vendor\Elasticsearch\bin\elasticsearch.bat"" --startupDir=""{app}\vendor\Elasticsearch"" --security-descriptor='D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCLCSWLOCRRC;;;BA)'"; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "install --name=""IsolationSIEM-Kafka"" --path=""{app}\vendor\Kafka\bin\windows\kafka-server-start.bat"" --params=""{app}\vendor\Kafka\config\kraft\server.properties"" --deps=""IsolationSIEM-Elasticsearch"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "install --name=""IsolationSIEM-Kibana"" --path=""{app}\vendor\Kibana\bin\kibana.bat"" --startupDir=""{app}\vendor\Kibana"" --deps=""IsolationSIEM-Elasticsearch"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "install --name=""IsolationSIEM-Ollama"" --path=""{app}\vendor\ollama\ollama.exe"" --params=""serve"" --startupDir=""{app}\vendor\ollama"" --env='OLLAMA_MODELS={app}\vendor\ollama\models'"; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "install --name=""IsolationSIEM-Producer"" --path=""{app}\bin\producer.exe"" --startupDir=""{app}\bin"" --deps=""IsolationSIEM-Kafka"" --enableSizeRotation --rotationSize=10"; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "install --name=""IsolationSIEM-Processor"" --path=""{app}\bin\processor.exe"" --startupDir=""{app}\bin"" --deps='IsolationSIEM-Kafka;IsolationSIEM-Ollama' --enableSizeRotation --rotationSize=10"; Flags: runhidden

; Post-install background initialization execution
Filename: "{app}\bin\servy-cli.exe"; Parameters: "start --name=""IsolationSIEM-Elasticsearch"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "start --name=""IsolationSIEM-Kafka"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "start --name=""IsolationSIEM-Kibana"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "start --name=""IsolationSIEM-Ollama"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "start --name=""IsolationSIEM-Producer"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "start --name=""IsolationSIEM-Processor"""; Flags: runhidden

[UninstallRun]
; Reverse ordering teardown during uninstallation
Filename: "{app}\bin\servy-cli.exe"; Parameters: "stop --name=""IsolationSIEM-Processor"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "stop --name=""IsolationSIEM-Producer"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "stop --name=""IsolationSIEM-Ollama"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "stop --name=""IsolationSIEM-Kibana"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "stop --name=""IsolationSIEM-Kafka"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "stop --name=""IsolationSIEM-Elasticsearch"""; Flags: runhidden

Filename: "{app}\bin\servy-cli.exe"; Parameters: "uninstall --name=""IsolationSIEM-Processor"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "uninstall --name=""IsolationSIEM-Producer"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "uninstall --name=""IsolationSIEM-Ollama"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "uninstall --name=""IsolationSIEM-Kibana"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "uninstall --name=""IsolationSIEM-Kafka"""; Flags: runhidden
Filename: "{app}\bin\servy-cli.exe"; Parameters: "uninstall --name=""IsolationSIEM-Elasticsearch"""; Flags: runhidden