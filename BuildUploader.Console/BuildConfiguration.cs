using Newtonsoft.Json;

namespace BuildUploader.Console
{
    internal class BuildConfiguration
    {
        [JsonProperty("unity")]
        public UnityCloudBuildSettings UnitySettings { get; internal set; }

        [JsonProperty("steam")]
        public SteamSettings SteamSettings { get; internal set; }
    }
}