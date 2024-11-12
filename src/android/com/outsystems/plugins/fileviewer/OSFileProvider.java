package com.outsystems.plugins.fileviewer;

import androidx.core.content.FileProvider;

/**
 * Empty Class that extends [androidx.core.content.FileProvider]
 * The purpose of this class is to avoid clashing with other file providers included in the app's manifest
 */
public class OSFileProvider extends FileProvider {
}
