namespace App.Utils {

    public class DataUtils {

        private Granite.Widgets.AlertView network_alert_view;

        public static string[] generate_data_set () {
            Soup.Session session = new Soup.Session ();
            string[] output = {};
            string uri = "https://www.gitignore.io/api/list";
            var message = new Soup.Message ("GET", uri);
            session.queue_message (message, (sess, mess) => {
                if (mess.status_code == 200) {
                        string response = (string) mess.response_body.flatten ().data;
                        string response_s = response.replace ("\n", ",");
                        output =  response_s.split (",");
                        
                } else {
                    debug ("Internet is required to use gitignore. Please check your network connection.");
                }
            });

            return output;
        }
    }
}