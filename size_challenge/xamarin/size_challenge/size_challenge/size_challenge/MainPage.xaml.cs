using System;
using Xamarin.Forms;

namespace size_challenge
{
    public partial class MainPage : ContentPage
	{
		public MainPage()
		{
			InitializeComponent();

            activityLoading.IsVisible = false;
            btnLoadComic.Clicked += BtnLoadComic_Clicked;
		}

        async private void BtnLoadComic_Clicked(object sender, EventArgs e)
        {
            activityLoading.IsVisible = true;
            var comicLoaded = await new Api(15).HttpGet(new Uri("https://xkcd.com/info.0.json"));
            if (comicLoaded != null)
            {
                lblTitle.Text = comicLoaded.Title;
                imgComic.Source = comicLoaded.ImageUrl;
            }
            activityLoading.IsVisible = false;

        }
    }


}
