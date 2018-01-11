namespace BuildUploader.Console
{
    internal class BuildDefinition
    {
        public int BuildNumber;

        public string FileName;

        public string DownloadUrl;

        public override string ToString()
        {
            return string.Format("Build({0})", this.FileName);
        }
    }
}
