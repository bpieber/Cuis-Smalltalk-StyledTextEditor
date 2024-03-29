'From Cuis 6.0 [latest update: #6032] on 17 September 2023 at 9:45:37 pm'!
'Description Please enter a description for this package'!
!provides: 'RTFClipboardTests' 1 1!
!requires: 'RTFImporting' 1 nil nil!
!requires: 'ExtendedClipboard' 1 nil nil!
!requires: 'RTFExporting' 1 nil nil!
!requires: 'RTFTests' 1 nil nil!
SystemOrganization addCategory: #RTFClipboardTests!


!classDefinition: #RTFClipboardTest category: #RTFClipboardTests!
TestCase subclass: #RTFClipboardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RTFClipboardTests'!
!classDefinition: 'RTFClipboardTest class' category: #RTFClipboardTests!
RTFClipboardTest class
	instanceVariableNames: ''!


!RTFClipboardTest methodsFor: 'testing' stamp: 'jmv 11/12/2013 08:45'!
testSample1ToAndFromRTFClipboard
	"
	ExtendedClipboardTest new testSample1ToAndFromRTFClipboard
	"
	| text |
	text _ RTFConversionTest textSample1.

	"This will use a refStreamed object"
	Clipboard default storeObject: text.
	self assert:Clipboard default retrieveObject = text.

	"This will also test storing and retrieving RTF data from platform Clipboard, and RTF conversion"
	ExtendedClipboardInterface current
		clearClipboard;
		addClipboardData: text rtfString dataFormat: 'public.rtf'.
	self assert:Clipboard default retrieveObject = text! !

!RTFClipboardTest methodsFor: 'testing' stamp: 'jmv 11/12/2013 08:45'!
testSample2ToAndFromRTFClipboard
	"
	ExtendedClipboardTest new testSample2ToAndFromRTFClipboard
	"
	| text |
	text _ RTFConversionTest textSample2.

	"This will use a refStreamed object"
	Clipboard default storeObject: text.
	self assert:Clipboard default retrieveObject = text.

	"This will also test storing and retrieving RTF data from platform Clipboard, and RTF conversion"
	ExtendedClipboardInterface current
		clearClipboard;
		addClipboardData: text rtfString dataFormat: 'public.rtf'.
	self assert:Clipboard default retrieveObject = text! !

!RTFClipboardTest methodsFor: 'testing' stamp: 'jmv 11/12/2013 08:46'!
testSample3ToAndFromRTFClipboard
	"
	ExtendedClipboardTest new testSample3ToAndFromRTFClipboard
	"
	| text |
	text _ RTFConversionTest textSample3.

	"This will use a refStreamed object"
	Clipboard default storeObject: text.
	self assert:Clipboard default retrieveObject = text.

	"This will also test storing and retrieving RTF data from platform Clipboard, and RTF conversion"
	ExtendedClipboardInterface current
		clearClipboard;
		addClipboardData: text rtfString dataFormat: 'public.rtf'.
	self assert:Clipboard default retrieveObject = text! !

!RTFClipboardTest methodsFor: 'testing' stamp: 'jmv 11/12/2013 08:46'!
testSample4ToAndFromRTFClipboard
	"
	ExtendedClipboardTest new testSample4ToAndFromRTFClipboard
	"
	| text |
	text _ RTFConversionTest textSample4.

	"This will use a refStreamed object"
	Clipboard default storeObject: text.
	self assert:Clipboard default retrieveObject = text.

	"This will also test storing and retrieving RTF data from platform Clipboard, and RTF conversion"
	ExtendedClipboardInterface current
		clearClipboard;
		addClipboardData: text rtfString dataFormat: 'public.rtf'.
	self assert:Clipboard default retrieveObject = text! !

!RTFClipboardTest methodsFor: 'testing' stamp: 'jmv 11/12/2013 08:46'!
testSample5ToAndFromRTFClipboard
	"
	ExtendedClipboardTest new testSample5ToAndFromRTFClipboard
	"
	| text |
	text _ RTFConversionTest textSample5.

	"This will use a refStreamed object"
	Clipboard default storeObject: text.
	self assert:Clipboard default retrieveObject = text.

	"This will also test storing and retrieving RTF data from platform Clipboard, and RTF conversion"
	ExtendedClipboardInterface current
		clearClipboard;
		addClipboardData: text rtfString dataFormat: 'public.rtf'.
	self assert:Clipboard default retrieveObject = text! !

!RTFClipboardTest methodsFor: 'testing' stamp: 'jmv 9/17/2023 21:44:56'!
testSample6ToAndFromRTFClipboard
	"
	ExtendedClipboardTest new testSample6ToAndFromRTFClipboard
	"
	| text |
	text := RTFConversionTest textSample6.

	"This will use a refStreamed object"
	Clipboard default storeObject: text.
	self assert:Clipboard default retrieveObject = text.

	"This will also test storing and retrieving RTF data from platform Clipboard, and RTF conversion"
	self deny: text rtfString = '{\rtf
{\colortbl;}
Tomá agüita, ñandú. Ñandú. \par œŽ®¥šøå߃©ݲެ­禵.\par ŒŽ®hØÅÍÎϩÓÔÞҭǦÐÂ}'.
	self assert: text rtfString =  '{\rtf
{\colortbl;}
Tom\u225? ag\u252?ita, \u241?and\u250?. \u209?and\u250?. \par  \u339?\u381?\u174?\u165?\u353?\u248?\u229?\u223?\u8484?\u169?\u221?\u178?\u222?\u172?\u173?\u231?\u352?\u181?.\par  \u338?\u381?\u174?\u193?\u353?\u216?\u197?\u205?\u206?\u207?\u169?\u211?\u212?\u222?\u210?\u173?\u199?\u352?\u208?\u194?}'.
	ExtendedClipboardInterface current
		clearClipboard;
		addClipboardData: text rtfString asUtf8Bytes dataFormat: 'public.rtf'.
	self assert: Clipboard default retrieveObject = text! !
