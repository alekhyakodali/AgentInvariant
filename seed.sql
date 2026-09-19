CREATE TABLE coverage (
    member_id TEXT NOT NULL,
    procedure TEXT NOT NULL,
    active INTEGER NOT NULL CHECK (active IN (0, 1)),
    PRIMARY KEY (member_id, procedure)
);

CREATE TABLE auth_requirements (
    member_id TEXT NOT NULL,
    procedure TEXT NOT NULL,
    auth_required INTEGER NOT NULL CHECK (auth_required IN (0, 1)),
    requirement_text TEXT NOT NULL,
    PRIMARY KEY (member_id, procedure)
);

CREATE TABLE business_approvals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id TEXT NOT NULL,
    procedure TEXT NOT NULL,
    status TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (member_id, procedure)
);

CREATE TABLE prior_auth_submissions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id TEXT NOT NULL,
    procedure TEXT NOT NULL,
    status TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO coverage (member_id, procedure, active)
VALUES ('4821', 'X', 1);

INSERT INTO auth_requirements (
    member_id,
    procedure,
    auth_required,
    requirement_text
)
VALUES (
    '4821',
    'X',
    1,
    'Matching business approval must be recorded before submission.'
);
