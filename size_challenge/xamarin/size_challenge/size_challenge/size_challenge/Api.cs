using Newtonsoft.Json;
using System;
using System.Diagnostics;
using System.Net.Http;
using System.Threading.Tasks;

namespace size_challenge
{
    public class Comic
    {
        [JsonProperty("img")]
        public string ImageUrl { get; set; }

        [JsonProperty("title")]
        public string Title { get; set; }
    }

    class Api
    {
        readonly TimeSpan _restTimeout;

        public Api(double RestTimeoutSec)
        {
            _restTimeout = TimeSpan.FromSeconds(RestTimeoutSec);
        }

        async public Task<Comic> HttpGet(Uri prmUri)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.Timeout = _restTimeout;
                    HttpResponseMessage response = null;
                    response = await client.GetAsync(prmUri).ConfigureAwait(false);

                    if (!response.IsSuccessStatusCode)
                    {
                        Debug.WriteLine(@"HttpGet Error");
                        return null;
                    }
                    // verifica contenuto della risposta
                    string responseBody = await response.Content.ReadAsStringAsync();
                    if (string.IsNullOrEmpty(responseBody))
                    {
                        Debug.WriteLine(@"HttpGet Empty Response");
                        return null;
                    }

                    return JsonConvert.DeserializeObject<Comic>(responseBody);
                }
            }
            catch (TaskCanceledException exCanceled)
            {
                // errore di altro tipo
                Debug.WriteLine(@"HttpGet Timeout Exception: {0}", exCanceled.Message);
                return null;
            }
            catch (Exception ex)
            {
                // errore di altro tipo
                Debug.WriteLine(@"HttpGet Exception: {0}", ex.Message);
                return null;
            }
        }
    }
}
