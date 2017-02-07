package guacamole;

import org.joda.time.LocalTime;

import java.io.IOException;
import java.util.ResourceBundle;
import java.util.jar.Attributes;
import java.util.jar.Manifest;

public class PotatoMain {
    public static void main(String[] args) {
        LocalTime currentTime = new LocalTime();
        System.out.println("The current local time is " + currentTime + ".");

        Potato potato = new Potato();
        System.out.println(potato.shoutHello());
        System.out.println(potato.ropeHei());

        System.out.println("Verify Resource bundle.");
        ResourceBundle bundle = ResourceBundle.getBundle("build");
        System.out.println(bundle.getString("build.message"));

        System.out.println("\nVerify Generated MANIFEST.MF Properties");
        Manifest manifest = new Manifest();
        try {
            manifest.read(Thread.currentThread().getContextClassLoader()
                .getResourceAsStream("META-INF/MANIFEST.MF"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        Attributes attributes = manifest.getMainAttributes();
        System.out.println("ContosoTag1: " + attributes.getValue("ContosoTag1"));
        System.out.println("ContosoTag2: " + attributes.getValue("ContosoTag2"));
    }
}
