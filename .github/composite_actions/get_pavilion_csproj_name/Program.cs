using System.Text.RegularExpressions;
using System.IO;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        var unityProjectDir = args[0];
        var repositoryName = args[1];

        var match = Regex.Match(repositoryName, @"^kidsstar/pretendland_(.+)$");
        if (!match.Success)
        {
            throw new InvalidOperationException("リポジトリ名が想定した形式ではありません。");
        }

        var pavilionName = match.Groups[1].Value;

        var pavilionProjFile = Directory.GetFiles(unityProjectDir)
                .Select(filePath => Path.GetFileName(filePath))
                .Where(fileName => fileName.ToLower() == $"pretendland.{pavilionName}.csproj")
                .FirstOrDefault();

        if (pavilionProjFile == null)
        {
            throw new FileNotFoundException("条件に合致するcsprojファイルが見つかりませんでした。");
        }
        
        Console.WriteLine(pavilionProjFile);
    }
}

