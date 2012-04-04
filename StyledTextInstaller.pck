'From Cuis 4.0Alpha of 29 March 2012 [latest update: #1237] on 4 April 2012 at 6:06:42 pm'!
'Description Description Description Description '!
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

!StyledTextInstaller methodsFor: 'features' stamp: 'bp 12/21/2011 10:34'!
                             featuresModelNames
	^#('STE - New Features' 'STE - Open Features' 'STE - Done Features' 'Cuis Features')! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/4/2012 18:06'!
fileDirectory
	| repositoryPath |
	repositoryPath _ FileDirectory dirPathFor: (CodePackage named: 'StyledTextInstaller') fullFileName.
	^FileDirectory on: repositoryPath! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'jmv 4/3/2012 10:14'!
                              install
	"
	StyledTextInstaller new install
	"
	self styledTextPackages do: [:each | self installPackage: each].
	STETheme beCurrent.
	self openExamples! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 4/4/2012 15:21'!
                installPackage: packageName
	| versionName |
	versionName := self fileDirectory lastNameFor: packageName extension: 'pck'.
	versionName _ packageName, '.pck'.
	CodeFileBrowser installPackage: (self fileDirectory readOnlyFileNamed: versionName)! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 08:54'!
                    open: name
	| file model |
	file _ FileStream fileNamed: name , '.object'.
	[model _ (SmartRefStream on: file) next] ensure: [file close].
	^SystemWindow editFancierStyledText: model label: name! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 10:10'!
     openExamples
	"self new openExamples"
	self
		openStyledTextEditorDocumentation;
		openMacbethExample! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 08:55'!
  openMacbethExample
	"self new openMacbethExample"
	| window |
	window _ self open: 'Macbeth Example'.
	window color: Color white! !

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:58'!
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

!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'jmv 4/3/2012 10:13'!
         styledTextPackages
	^#('RTFImporting' 'RTFExporting' 'RTFTests' 'FFI' 'ExtendedClipboard' 'CrappyOSProcess' 'StyledText' 'StyledTextNotebook' 'StyledTextWiki')! !
