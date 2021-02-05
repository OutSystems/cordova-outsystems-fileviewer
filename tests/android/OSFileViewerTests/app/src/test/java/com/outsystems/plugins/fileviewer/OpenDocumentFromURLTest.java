package com.outsystems.plugins.fileviewer;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Unit tests for the OpenDocumentFromURL functionality.
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
public class OpenDocumentFromURLTest {

    @Test
    public void given_ValidURL_When_CheckingIsPathValid_Then_URLIsValid(){

        assertTrue(OSOpenDocument.getInstance().isPathValid("https://www.tutorialspoint.com/swift/swift_tutorial.pdf"));

    }

    @Test
    public void given_ValidURL_When_CheckingIsURLValid_Then_URLIsValid(){

        assertTrue(OSOpenDocument.getInstance().isURLValid("https://www.tutorialspoint.com/swift/swift_tutorial.pdf"));

    }

    @Test
    public void given_MalformedURL_When_CheckingIsURLValid_Then_URLIsNotValid(){

        assertFalse(OSOpenDocument.getInstance().isURLValid("aaaaa"));

    }

    @Test
    public void given_EmptyURL_When_CheckingIsURLValid_Then_URLIsNotValid(){

        assertFalse(OSOpenDocument.getInstance().isURLValid(""));

    }

}