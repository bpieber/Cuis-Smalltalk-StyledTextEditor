'From Cuis 4.0 of 21 April 2012 [latest update: #1260] on 22 April 2012 at 1:41:19 pm'!
'Description A small package whose purpose is to install the rest of the packages that comprise the StyledTextEditor project.'!
!classDefinition: #StyledTextInstaller category: #StyledTextInstaller!
Object subclass: #StyledTextInstaller
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StyledTextInstaller'!
!classDefinition: 'StyledTextInstaller class' category: #StyledTextInstaller!
StyledTextInstaller class
	instanceVariableNames: ''!


!StyledTextInstaller methodsFor: 'private' stamp: 'bp 12/4/2011 09:14'!
createStyledTextEditorDocumentation
	"self new createStyledTextEditorDocumentation"
	| model styleSet |
	model _ StyledTextModel new.
	SystemWindow
		editFancierStyledText: model
		label: 'Styled Text Editor Documentation'.
	styleSet _ model styleSet.
	styleSet
		createDocumentationParagraphStyleSet;
		createDocumentationCharacterStyleSet! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 4/5/2012 23:13'!
documentsDirectory
	^self repositoryDirectory directoryNamed: 'Documents'! !

!StyledTextInstaller methodsFor: 'features' stamp: 'bp 4/21/2012 14:58'!
featuresModelNames
	^#('STE - New Features' 'STE - Done Features' 'Cuis Features')! !

!StyledTextInstaller methodsFor: 'public' stamp: 'bp 4/20/2012 21:37'!
install
	"
	StyledTextInstaller new install
	"
	self installPackages: self styledTextPackages.
	STETheme beCurrent.
	self openExamples! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 4/5/2012 23:10'!
installPackage: packageName
	| versionName |
	versionName := self repositoryDirectory lastNameFor: packageName extension: 'pck'.
	versionName _ packageName, '.pck'.
	CodeFileBrowser installPackage: (self repositoryDirectory readOnlyFileNamed: versionName)! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 4/20/2012 21:31'!
installPackages: packages
	packages do: [:each | self installPackage: each]! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 4/22/2012 13:23'!
open: name
	| fileName model |
	fileName _ self documentsDirectory fullNameFor: name.
	model _ StyledTextModel fromFileNamed: fileName.
	^SystemWindow editFancierStyledText: model label: name! !

!StyledTextInstaller methodsFor: 'public' stamp: 'bp 12/4/2011 10:10'!
openExamples
	"self new openExamples"
	self
		openStyledTextEditorDocumentation;
		openMacbethExample! !

!StyledTextInstaller methodsFor: 'public' stamp: 'bp 4/5/2012 23:24'!
openMacbethExample
	"self new openMacbethExample"
	| window |
	window _ self open: 'Macbeth Example'.
	window ifNotNil: [window color: Color white]! !

!StyledTextInstaller methodsFor: 'public' stamp: 'bp 4/5/2012 23:24'!
openStyledTextEditorDocumentation
	"self new openStyledTextEditorDocumentation"
	self open: 'Styled Text Editor Documentation'! !

!StyledTextInstaller methodsFor: 'public' stamp: 'bp 12/7/2011 02:06'!
openStyledTextEditorFeatures
	"self new openStyledTextEditorFeatures"
	self featuresModelNames do: [:each | self open: each]! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 12/4/2011 10:06'!
recreateDocumentationStyleSet
	"self new recreateDocumentationStyleSet"
	| model styleSet |
	model _ self styledTextModelNamed: 'Styled Text Editor Documentation'.
	styleSet _ model styleSet.
	styleSet
		createDocumentationParagraphStyleSet;
		createDocumentationCharacterStyleSet! !

!StyledTextInstaller methodsFor: 'features' stamp: 'bp 12/7/2011 02:08'!
recreateFeaturesStyleSet
	"self new recreateFeaturesStyleSet"
	self featuresModelNames do: [:each |
		| model styleSet |
		model _ self styledTextModelNamed: each.
		styleSet _ model styleSet.
		styleSet
			createFeaturesParagraphStyleSet;
			createFeaturesCharacterStyleSet]! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 4/5/2012 23:10'!
repositoryDirectory
	^(FileDirectory on: (CodePackage named: 'StyledTextInstaller') fullFileName) containingDirectory! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 4/20/2012 21:19'!
save: name
	| model |
	model _ self styledTextModelNamed: name.
	model saveAs: (self documentsDirectory fullNameFor: name)! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 12/4/2011 09:40'!
saveStyledTextEditorDocumentation
	"self new saveStyledTextEditorDocumentation"
	self save: 'Styled Text Editor Documentation'! !

!StyledTextInstaller methodsFor: 'features' stamp: 'bp 12/7/2011 02:07'!
saveStyledTextEditorFeatures
	"self new saveStyledTextEditorFeatures"
	self featuresModelNames do: [:each | self save: each]! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 12/4/2011 09:59'!
styledTextModelNamed: name
	| window |
	window _ SystemWindow allInstances detect: [:each | each label = name].
	^window model! !

!StyledTextInstaller methodsFor: 'private' stamp: 'bp 4/4/2012 19:50'!
styledTextPackages
	^#('RTFImporting' 'RTFExporting' 'RTFTests' 'FFI' 'ExtendedClipboard' 'CrappyOSProcess' 'StyledText' 'StyledTextNotebook' 'StyledTextWiki')! !

!StyledTextInstaller methodsFor: 'public' stamp: 'bp 4/22/2012 11:23'!
update
	"
	StyledTextInstaller new update
	"
	self installPackages: (self styledTextPackages asOrderedCollection add: self class name; yourself)! !
