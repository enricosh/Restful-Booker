package util;

import com.intuit.karate.driver.chrome.Chrome;

import java.util.Base64;

public class UtilClass {

    public static String getPayLoadJWT(String jwt){
        Base64.Decoder decoder = Base64.getUrlDecoder();
        String[] chunks = jwt.split("\\.");
        String payload = new String(decoder.decode(chunks[1]));
        //System.out.println("payload: " + payload);
        return payload;
    }

    public static void onlyPrint() {
        System.out.println(">>> Este es un mensaje cualquiera");
    }

    public static void onlyPrint(String message) {
        System.out.println(">>> Message: " + message);
    }

    public static void typeToken(String token) throws InterruptedException {
        for(char t : token.toCharArray()){
            System.out.println("Type key: " + t);
            Thread.sleep(1000);
        }
    }

    public static void lazyInput(Chrome driver, String locator, String captcha) throws InterruptedException {
        for (char i : captcha.toCharArray()) {
            Thread.sleep(500);
            driver.input(locator, "" + i);
        }
    }

    public static void typeToken(Chrome driver, String token) {
        String[] numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"};
        String query = "document.querySelector('#passbc')" +
                ".shadowRoot.querySelector('div.input-password > div > bcp-keyboard > div > div > " +
                "bcp-keyboard-key:nth-child(%s) > div > bcp-title > h3')";
        for (char tokenKey : token.toCharArray()) {
            for (String number : numbers) {
                String innerQuery = String.format(query + ".innerHTML=='%s'", number, tokenKey);
                Object document = driver.script(innerQuery);
                if ((Boolean) document) {
                    String clickQuery = String.format(query + ".click()", number);
                    driver.script(clickQuery);
                    driver.delay(500);
                    break;
                }
            }
        }
    }

    public static String decodeB64(String encode){
        return new String(Base64.getDecoder().decode(encode));
    }

    public static String encodeB64(String encode){
        return Base64.getEncoder().encodeToString(encode.getBytes());
    }

}