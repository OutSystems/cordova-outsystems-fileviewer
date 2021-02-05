package com.outsystems.plugins.fileviewer;

import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Unit tests for the OpenDocumentFromURL functionality.
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
public class OpenDocumentFromLocalPathTest {

    @Test
    public void given_ValidFilePath_When_CheckingIsPathValid_Then_FilePathIsValid(){
        assertTrue(OSOpenDocument.getInstance().isPathValid("file:///storage/emulated/0/android/media/com.outsystems.rd.FileViewerTest/nomePDF.pdf"));
    }

    @Test
    public void given_EmptyPath_When_CheckingIsPathValid_Then_PathIsNotValid(){
        assertFalse(OSOpenDocument.getInstance().isPathValid(""));
    }

}