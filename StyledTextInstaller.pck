'From Cuis 4.0 of 3 April 2012 [latest update: #1253] on 12 April 2012 at 5:49:15 pm'!
'Description Description Description Description Description Description Description Description '!
!classDefinition: #StyledTextInstaller category: #StyledTextInstaller!
Object subclass: #StyledTextInstaller
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StyledTextInstaller'!
!classDefinition: 'StyledTextInstaller class' category: #StyledTextInstaller!
StyledTextInstaller class
	instanceVariableNames: ''!


!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:14'!
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

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/5/2012 23:13'!
documentsDirectory
	^self repositoryDirectory directoryNamed: 'Documents'! !

!StyledTextInstaller methodsFor: 'features' stamp: 'bp 12/21/2011 10:34'!
featuresModelNames
	^#('STE - New Features' 'STE - Open Features' 'STE - Done Features' 'Cuis Features')! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/12/2012 17:48'!
install
	"
	StyledTextInstaller new install
	"
	self installPackages.
	STETheme beCurrent.
	self openExamples! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/5/2012 23:10'!
installPackage: packageName
	| versionName |
	versionName := self repositoryDirectory lastNameFor: packageName extension: 'pck'.
	versionName _ packageName, '.pck'.
	CodeFileBrowser installPackage: (self repositoryDirectory readOnlyFileNamed: versionName)! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/12/2012 17:48'!
installPackages
	"
	StyledTextInstaller new installPackages
	"
	self styledTextPackages do: [:each | self installPackage: each]! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/5/2012 23:22'!
open: name
	| file model |
	file _ self documentsDirectory oldFileNamed: name, '.object'.
	file ifNil: [^nil].
	[model _ (SmartRefStream on: file) next] ensure: [file close].
	^SystemWindow editFancierStyledText: model label: name! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 10:10'!
openExamples
	"self new openExamples"
	self
		openStyledTextEditorDocumentation;
		openMacbethExample! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/5/2012 23:24'!
openMacbethExample
	"self new openMacbethExample"
	| window |
	window _ self open: 'Macbeth Example'.
	window ifNotNil: [window color: Color white]! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/5/2012 23:24'!
openStyledTextEditorDocumentation
	"self new openStyledTextEditorDocumentation"
	self open: 'Styled Text Editor Documentation'! !

!StyledTextInstaller methodsFor: 'features' stamp: 'bp 12/7/2011 02:06'!
openStyledTextEditorFeatures
	"self new openStyledTextEditorFeatures"
	self featuresModelNames do: [:each | self open: each]! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 10:06'!
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

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/5/2012 23:10'!
repositoryDirectory
	^(FileDirectory on: (CodePackage named: 'StyledTextInstaller') fullFileName) containingDirectory! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'jmv 1/6/2012 14:12'!
save: name
	| model |
	model _ self styledTextModelNamed: name.
	model saveAs: name! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:40'!
saveStyledTextEditorDocumentation
	"self new saveStyledTextEditorDocumentation"
	self save: 'Styled Text Editor Documentation'! !

!StyledTextInstaller methodsFor: 'features' stamp: 'bp 12/7/2011 02:07'!
saveStyledTextEditorFeatures
	"self new saveStyledTextEditorFeatures"
	self featuresModelNames do: [:each | self save: each]! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:59'!
styledTextModelNamed: name
	| window |
	window _ SystemWindow allInstances detect: [:each | each label = name].
	^window model! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/4/2012 19:50'!
styledTextPackages
	^#('RTFImporting' 'RTFExporting' 'RTFTests' 'FFI' 'ExtendedClipboard' 'CrappyOSProcess' 'StyledText' 'StyledTextNotebook' 'StyledTextWiki')! !
