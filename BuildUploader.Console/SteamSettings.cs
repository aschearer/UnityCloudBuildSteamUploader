using Newtonsoft.Json;

namespace BuildUploader.Console
{
    internal class SteamSettings
    {
        [JsonProperty("app_id")]
        public string AppId { get; internal set; }

        [JsonProperty("display_name")]
        public string DisplayName { get; internal set; }

        [JsonProperty("branch_name")]
        public string BranchName { get; internal set; }

        [JsonProperty("username")]
        public string Username { get; internal set; }

        [JsonProperty("password")]
        public string Password { get; internal set; }

        [JsonProperty("app_script")]
        public string AppScript { get; internal set; }

        [JsonProperty("content_dir")]
        public string ContentDir { get; internal set; }

        [JsonProperty("exe_path")]
        public string ExecutablePath { get; internal set; }
    }
}