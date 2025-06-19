using System.IO;
using System.Text.RegularExpressions;

class Program
{
    private const string UnityEditorExecutablePathFormat = "/Applications/Unity/Hub/Editor/{0}/Unity.app/Contents/MacOS/Unity";

    static void Main(string[] args)
    {
        var unityProjectDir = args[0];
        var projectVersionFilePath = Path.Combine(unityProjectDir, "ProjectSettings", "ProjectVersion.txt");

        if (!File.Exists(projectVersionFilePath))
        {
            throw new FileNotFoundException("ProjectVersion.txtが見つかりませんでした。", projectVersionFilePath);
        }

        var editorVersion = File.ReadAllLines(projectVersionFilePath)
            .Select(line => Regex.Match(line, @"^m_EditorVersion:\s*(.+)$"))
            .Where(m => m.Success)
            .Select(m => m.Groups[1].Value)
            .FirstOrDefault();

        if (string.IsNullOrEmpty(editorVersion))
        {
            throw new InvalidOperationException("Unityエディタのバージョンを特定できませんでした。");
        }

        var unityEditorExecutablePath = string.Format(UnityEditorExecutablePathFormat, editorVersion);

        Console.WriteLine(unityEditorExecutablePath);
    }        
        

}

