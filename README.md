StyledTextEditor
----------------

This is the StyledTextEditor project for Cuis, brought to you by Bernhard Pieber and Juan Vuletich. The design of the Styled Text Editor toolbar and scrollbars was done by Sabine Gasper-Mautes.

### Installation ###

Steps to install:

Install Cuis Smalltalk using Git, following https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev/blob/master/Documentation/GettingStarted.md

On the folder where you have ./Cuis-Smalltalk-Dev/ do
```
git clone https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-StyledTextEditor.git
```

Then start Cuis, and in a Workspace evaluate:
```
Feature require: 'StyledTextInstaller'
```

### Features ###

The Styled Text Editor is a framework for rich text editing using styles as known from popular word processors like Apple Pages or Microsoft Word. It features paragraph and character styles, allowing easy text formatting using styles only. It is intended for applications where users need to work with good looking rich text in a simple and fast way.

Rich text commonly refers to text with formatting information like different fonts, sizes, alignments, and emphasis. To make editing as simple as possible instead of individual formatting information end users apply styles to parts of the text. Editing is made fast by keyboard shortcuts for text navigation, selection, and styles selection. Where possible the feel of widely used rich text editors is supported.

The editor includes features like
- numbered and bulleted list paragraph styles
- support for images
- multiple level undo and redo
- text completion using various glossaries including a dictionary of English with about 166.000 words
- RTF clipboard (on OS X VMs with the ClipboardExtendedPlugin, included in the Pharo VMs)

The Styled Text Editor is developed in Cuis with the plan to eventually port it to Squeak and Pharo. The development of the Styled Text Editor inspired many changes to Cuis itself, and It is the first package to use the brand new DVCS based development process for external packages for Cuis 4.0. 

### Acknowlegements ###

The idea and funding was provided Bernhard Pieber and his company Software Generation. The implementation was done by Juan Vuletich, the mastermind behind Cuis. Thanks Juan for the close cooperation. It was and still is great fun to work with you.

Bernhard and Juan are looking forward to feedback from you. Fork it, create issues and send pull requests. ;-)


### References ###

[1] http://www.esug.org/wiki/pier/Conferences/2011/Schedule-And-Talks/StyledTextEditor

[2] http://www.youtube.com/watch?v=pUoVbvwspi8&list=PL813665D04A2E4C0A&index=7&feature=plpp_video
