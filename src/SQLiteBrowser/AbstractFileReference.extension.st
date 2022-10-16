Extension { #name : #AbstractFileReference }

{ #category : #'*SQLiteBrowser' }
AbstractFileReference >> gtSqlTablesFor: aView [
	<gtView>
	(self isFile
		and: [ (#('db' 'sqlite') includes: self extension)
				and: [ (self readStreamDo: [ :s | s next: 16 ])
						= ('SQLite format 3',
							Character null asString) ] ])
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'SQLite tables';
		priority: 10;
		object: [ SQLiteDatabase file: self ];
		view: #gtTablesFor:;
		yourself
]
