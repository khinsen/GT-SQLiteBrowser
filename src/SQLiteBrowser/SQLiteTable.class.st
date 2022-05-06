Class {
	#name : #SQLiteTable,
	#superclass : #Object,
	#instVars : [
		'database',
		'properties'
	],
	#category : #SQLiteBrowser
}

{ #category : #'instance creation' }
SQLiteTable class >> properties: aDictionary in: aDatabase [
	^ self new
		database: aDatabase;
		properties: aDictionary
]

{ #category : #accessing }
SQLiteTable >> columnNames [
	^ self database
		runSQL: '
			SELECT *
			FROM ', self name, ';'
		with: [ :result |
					result next columnNames ]
]

{ #category : #accessing }
SQLiteTable >> database [
	^ database
]

{ #category : #accessing }
SQLiteTable >> database: aDatabase [
	database := aDatabase
]

{ #category : #inspecting }
SQLiteTable >> gtDataFor: aView [
	<gtView>
	| view |
	view := aView columnedList
		title: 'Data';
		priority: 1;
		items: [ self rows ];
		yourself.
	self columnNames do: [ :each |
		view column: each text: [ :row | row atName: each ] ].
	^ view
]

{ #category : #inspecting }
SQLiteTable >> gtSchemaFor: aView [
	<gtView>
	^ aView forward
		title: 'Schema';
		priority: 5;
		object: [ self schema ];
		view: #gtStringFor:;
		yourself
]

{ #category : #accessing }
SQLiteTable >> name [
	^ self properties at: #name
]

{ #category : #accessing }
SQLiteTable >> numberOfRows [
	^ self database
		runSQL: 'SELECT COUNT(*) FROM ', self name , ';'
		with: [ :each | each next at: 1 ]
]

{ #category : #printing }
SQLiteTable >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(;
		<< (self properties at: #name);
		<< ', ';
		<< self numberOfRows asString;
		<< ' rows)'
]

{ #category : #accessing }
SQLiteTable >> properties [
	^ properties
]

{ #category : #accessing }
SQLiteTable >> properties: aDictionary [
	properties := aDictionary
]

{ #category : #accessing }
SQLiteTable >> rows [
	^ self database
		runSQL: '
			SELECT *
			FROM ', self name, '
			LIMIT 1000;'
		with: [ :result |
					result rows collect: [ :each | each ] ]
]

{ #category : #accessing }
SQLiteTable >> schema [
	^ self properties at: #sql
]
