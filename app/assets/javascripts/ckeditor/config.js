/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'it';
	config.uiColor = '#007C43';
	config.font_names = 'Task Font/Lucida Console, Courier New; Normal/Arial, Calibri, Helvetica';
	
	// Toolbar configuration generated automatically by the editor based on config.toolbarGroups.
  config.toolbar = [
	  { name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'NewPage' ] },
	  { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
	  { name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ], items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
	  { name: 'paragraph', groups: [ 'list', 'liststyle', 'indent' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent' ] },
	  '/',
	  { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
	  { name: 'styles', items: [ 'Font', 'FontSize' ] },
	  { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
	  '/',
	  { name: 'links', items: [ 'Link', 'Unlink' ] },
	  { name: 'insert', items: [ 'Smiley', 'SpecialChar' ] },
	  { name: 'others', items: [ '-' ] },
	  { name: 'about', items: [ 'About' ] }
  ];

};
