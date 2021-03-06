package com.outsystems.plugins.fileviewer;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertTrue;

/**
 * Unit tests for the OpenDocumentFromURL functionality.
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
public class OpenDocumentFromLocalPathTest {

    @Test
    public void given_ValidFilePathPDF_When_CheckingIsPathValid_Then_FilePathIsValid(){
        assertTrue(OSOpenDocument.getInstance().isPathValid("file:///storage/emulated/0/Android/data/com.outsystemsenterprise.enmobile11dev.FileSampleApp/files/Downloads/pdf_example.pdf"));
    }

    @Test
    public void given_ValidFilePathVideo_When_CheckingIsPathValid_Then_FilePathIsValid(){
        assertTrue(OSOpenDocument.getInstance().isPathValid("file:///storage/emulated/0/Android/data/com.outsystemsenterprise.enmobile11dev.FileSampleApp/files/Downloads/video_sample.mp4"));
    }

    @Test
    public void given_EmptyPath_When_CheckingIsPathValid_Then_PathIsNotValid(){
        assertFalse(OSOpenDocument.getInstance().isPathValid(""));
    }

    @Test
    public void given_pdfMimeType_When_GettingMimeTypeForPathWithPDFExtension_Then_PDFMimeTypeReturned() {
        GetMimeTypeMock mimeTypeMock = new GetMimeTypeMock();
        assertEquals("application/pdf", mimeTypeMock.determineMimeType("file:///storage/emulated/0/android/media/com.outsystems.rd.FileViewerTest/nomePDF.pdf"));
    }

    //Work in Progress - this is just an idea, to use mocks.
    @Test
    public void given_pdfMimeType_When_GettingMimeTypeForPathWithoutPDFExtension_Then_PDFMimeTypeNotReturned() {
        GetMimeTypeMock mimeTypeMock = new GetMimeTypeMock();
        assertNotEquals("application/pdf", mimeTypeMock.determineMimeType("file:///storage/emulated/0/android/media/com.outsystems.rd.FileViewerTest/documento.doc"));
    }

}