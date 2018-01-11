using Newtonsoft.Json;

namespace BuildUploader.Console
{
    internal class UnityCloudBuildSettings
    {
        [JsonProperty("org_id")]
        public string OrganizationID { get; internal set; }

        [JsonProperty("project")]
        public string ProjectName { get; internal set; }

        [JsonProperty("target")]
        public string TargetId { get; internal set; }

        [JsonProperty("api_key")]
        public string APIKey { get; internal set; }
    }
}
