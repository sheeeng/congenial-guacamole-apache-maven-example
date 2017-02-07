package guacamole;

import static org.hamcrest.CoreMatchers.containsString;
import static org.junit.Assert.*;

import org.junit.Test;

public class PotatoTest {

	private Potato potato = new Potato();

	@Test
	public void potatoShoutHello() {
		assertThat(potato.shoutHello(), containsString("Hello"));
	}

    @Test
	public void potatoRopeHei() {
        assertThat(potato.ropeHei(), containsString("Hei"));
	}

}