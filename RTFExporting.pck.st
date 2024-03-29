'From Cuis 6.0 [latest update: #6032] on 17 September 2023 at 7:56:05 pm'!
'Description Please enter a description for this package.'!
!provides: 'RTFExporting' 1 5!
!requires: 'Graphics-Files-Additional' 1 nil nil!



!CharacterSequence methodsFor: '*rtfExporting' stamp: 'bp 9/17/2023 19:54:03'!
asUnicodeRTF
	"Convert the given character sequence to Unicode RTF"
	"
	self assert: 'A¢€' rtfString = 'A\u162?\u8364?'
	"
	| c cp |
	^String streamContents: [ :strm | | characters |
		characters := self readStream.
		[ characters atEnd ] whileFalse: [
			c :=  characters next.
			cp := c codePoint.
			cp < 128
				ifTrue: [ strm nextPut: c ]
				ifFalse: [
					strm
						nextPut: $\;
						nextPut: $u.
					cp printOn: strm.
					strm nextPut: $? ]]]! !

!Text methodsFor: '*rtfExporting' stamp: 'bp 9/17/2023 19:54:47'!
rtfString
	"
	| text |
	text _ RTFConversionTest textSample1 asStyledText.
	StyledTextModel new contents: text; openAsStyledEditorLabel: 'Styled Text Editor' inWorld: World.
	Clipboard default storeObject: text
	"
	| prevAttributes colors fonts s |
	"Build colors and fonts tables"
	colors := Set new.
	fonts := Set new.
	runs withStartStopAndValueDo: [ :start :stop :attributes |
		attributes do: [ :attribute |
			attribute forParagraphStyleReferenceDo: [ :ts | ts color ifNotNil: [ :color | colors add: color ]].
			attribute forCharacterStyleReferenceDo: [ :cs | cs color ifNotNil: [ : color | colors add: color ]].
			attribute forTextColorDo: [ :color | colors add: color ].
			attribute forFontFamilyDo: [ :font | fonts add: font ]]].
	colors := colors asArray.
	fonts := fonts asArray.
	^String
		streamContents: [ :strm |
			self writeRTFHeaderOn: strm colorTable: colors fontTable: fonts.
			prevAttributes := #().
			runs withStartStopAndValueDo: [ :start :stop :attributes | | currentAttributes actualStart |
				currentAttributes := attributes asSet.
				"Close attributes no longer present"
				prevAttributes do: [ :each |
					(currentAttributes includes: each) ifFalse: [
						each writeRTFStopOn: strm colorTable: colors fontTable: fonts ]].
				"Open attributes not previously present"
				actualStart := start.
				currentAttributes do: [ :each |
					"Repeat existing, because the closing of other attributes, in some cases, sets defaults, and not the now active values...
					For example, finishing a CharStyle sets text to black. But what if the ParaStyle indicated some other color?"
					"(prevAttributes includes: each) ifFalse: ["
						actualStart := actualStart + (each writeRTFStartOn: strm colorTable: colors fontTable: fonts) 
						"]"
					].
				"Add string now"
				s := string copyFrom: actualStart to: stop.
				s := s withLineEndings: '\par '.
				s := s asUnicodeRTF.
				strm nextPutAll: s.
				prevAttributes := currentAttributes ].
			strm nextPut: $} ]
		estimatedSize: string size! !

!Text methodsFor: '*rtfExporting' stamp: 'jmv 3/13/2012 12:55'!
writeRTFHeaderOn: aStream colorTable: colorArray fontTable: fontNamesArray

	aStream nextPutAll: '{\rtf'; newLine.

	aStream nextPutAll: '{\colortbl;'.
	colorArray do: [:each | 
		aStream
			nextPutAll: '\red'; nextPutAll: (each red * 255) rounded asString;
			nextPutAll: '\green'; nextPutAll: (each green * 255) rounded asString;
			nextPutAll: '\blue'; nextPutAll: (each blue * 255) rounded asString;
			nextPut: $; ].
	aStream nextPutAll: '}'; newLine! !

!Text class methodsFor: '*rtfExporting' stamp: 'jmv 11/1/2011 10:40'!
pointSizeConversionFactor
	"This constant is used for conversion of font point sizes ofr RTF export and import.
	In theory, it shouldn't be needed. After all, a 72point font in RTF should be imported as a 72 point font in Cuis.
	
	Cuis uses 96 pixels per inch. This means that the inter baseline height for a 72 point font is (at least) 96 pixels.
	This is also the convention used (by default) on Windows, so fonts look about the same in Cuis and in Windows native software (such as Wordpad).
	But the Mac uses (by default) a convention of 72 pixels per inch. So, text on the Mac looks smaller.
	If this method is modified to answer 96/72, then text on the Mac will look the same as in Cuis. This could be good to make Mac users happy, as long as we never show them the point size we believe our fonts have. The font that they happily use export and import content, and to look side by side, that is called '12 points' in Mac software, well call '9 point'"
	"^1.33333"
	^1! !

!TextAttribute methodsFor: '*rtfExporting' stamp: 'jmv 1/24/2011 11:51'!
writeRTFStartOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute start. Return number of characters to skip (usually 0)"
	^0! !

!TextAttribute methodsFor: '*rtfExporting' stamp: 'jmv 1/21/2011 13:41'!
writeRTFStopOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute stop."! !

!TextAlignment methodsFor: '*rtfExporting' stamp: 'jmv 1/24/2011 11:52'!
writeRTFStartOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute start. Return number of characters to skip (usually 0)"
	alignment caseOf: {
		[ 0 ] -> [ aStream nextPutAll: '\ql ' ].
		[ 1 ] -> [ aStream nextPutAll: '\qr ' ].
		[ 2 ] -> [ aStream nextPutAll: '\qc ' ].
		[ 3 ] -> [ aStream nextPutAll: '\qj ' ] }.
	^0! !

!TextAlignment methodsFor: '*rtfExporting' stamp: 'jmv 1/21/2011 14:57'!
writeRTFStopOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute stop."
	aStream nextPutAll: '\ql '! !

!TextColor methodsFor: '*rtfExporting' stamp: 'jmv 1/24/2011 11:52'!
writeRTFStartOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute start. Return number of characters to skip (usually 0)"
	aStream nextPutAll: '\cf'; nextPutAll: (colorArray indexOf: color) asString; space.
	^0! !

!TextColor methodsFor: '*rtfExporting' stamp: 'jmv 1/21/2011 13:51'!
writeRTFStopOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute stop."
	aStream nextPutAll: '\cf0 '! !

!TextEmphasis methodsFor: '*rtfExporting' stamp: 'jmv 4/1/2016 13:45'!
writeRTFStartOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute start. Return number of characters to skip (usually 0)"

	(emphasisCode allMask: AbstractFont boldCode) ifTrue: [
		aStream nextPutAll: '\b ' ].
	(emphasisCode allMask: AbstractFont italicCode) ifTrue: [
		aStream nextPutAll: '\i ' ].
	(emphasisCode allMask: AbstractFont underlinedCode) ifTrue: [
		aStream nextPutAll: '\ul ' ].
	(emphasisCode allMask: AbstractFont struckThroughCode) ifTrue: [
		aStream nextPutAll: '\strike \strikec0 ' ].
	^0! !

!TextEmphasis methodsFor: '*rtfExporting' stamp: 'jmv 4/1/2016 13:46'!
writeRTFStopOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute stop.
	Do it in the inverse order of writeRTFStartOn:colorTable:fontTable:"

	(emphasisCode allMask: AbstractFont struckThroughCode) ifTrue: [
		aStream nextPutAll: '\strike0\striked0 ' ].
	(emphasisCode allMask: AbstractFont underlinedCode) ifTrue: [
		aStream nextPutAll: '\ulnone ' ].
	(emphasisCode allMask: AbstractFont italicCode) ifTrue: [
		aStream nextPutAll: '\i0 ' ].
	(emphasisCode allMask: AbstractFont boldCode) ifTrue: [
		aStream nextPutAll: '\b0 ' ]! !

!TextFontSize methodsFor: '*rtfExporting' stamp: 'bp 9/13/2023 19:45:38'!
writeRTFStartOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute start. Return number of characters to skip (usually 0)"
	"We should also reference familyName, in the table with \f# where # is the number in the table..."

	aStream nextPutAll: '\fs'; nextPutAll: ((pointSize * Text pointSizeConversionFactor ) rounded * 2) asString; space.
	^0! !

!TextFontSize methodsFor: '*rtfExporting' stamp: 'bp 9/13/2023 19:45:51'!
writeRTFStopOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute stop."
	aStream nextPutAll: '\fs0 '! !

!TextAnchor methodsFor: '*rtfExporting' stamp: 'jmv 4/7/2011 15:08'!
writeRTFStartOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute start. Return number of characters to skip: one in this case"
	aStream
		nextPutAll: '{\*\shppict{\pict\pngblip ';
		nextPutAll: (PNGReadWriter bytesFor: anchoredFormOrMorph) hex;
		nextPutAll: '}}'.
	"Skip the character holding the attribute"
	^1! !

!TextAnchor methodsFor: '*rtfExporting' stamp: 'jmv 1/24/2011 11:12'!
writeRTFStopOn: aStream colorTable: colorArray fontTable: fontArray
	"Write the RTF code for attribute stop."! !
