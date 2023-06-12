import '../../const.dart';

const initScript = [
  '''CREATE TABLE IF NOT EXISTS ${Const.accounts} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        account_name TEXT,
        account_type INT,
        parent_id INTEGER,
        is_deleted INTEGER
     )''',
  '''CREATE TABLE IF NOT EXISTS ${Const.categories} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_name TEXT,
        category_type INT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        icon TEXT,
        is_deleted INTEGER
     )''',
  '''CREATE TABLE IF NOT EXISTS ${Const.configs} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT,
        value TEXT
     )''',
  '''CREATE TABLE IF NOT EXISTS ${Const.trans} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        created_at INTEGER,
        amount REAL,
        desc TEXT,
        account_id INTEGER,
        category_id INTEGER,
        FOREIGN KEY (account_id) REFERENCES ${Const.accounts}(id),
        FOREIGN KEY (category_id) REFERENCES ${Const.categories}(id)
     )''',
  '''CREATE TABLE IF NOT EXISTS ${Const.transLinks} (
        link_id INTEGER PRIMARY KEY AUTOINCREMENT,
        trans_id INTEGER,
        batch_id TEXT,
        FOREIGN KEY (trans_id) REFERENCES ${Const.trans}(id) ON DELETE CASCADE
     )''',
  '''CREATE INDEX IF NOT EXISTS ConfigKeyIndex 
        ON ${Const.configs} (key)''',
];

const migrationScripts = [];
