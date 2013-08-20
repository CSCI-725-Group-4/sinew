-- Copyright Hadapt, Inc. 2013
-- All rights reserved.

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION document_type" to load this file. \quit

-- Serialization Functions

CREATE TYPE document;

CREATE OR REPLACE FUNCTION
string_to_document_datum(cstring)
RETURNS document
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION
document_datum_to_string(document)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE document (
    INPUT = string_to_document_datum,
    OUTPUT = document_datum_to_string
);

CREATE SCHEMA IF NOT EXISTS document_schema;
CREATE TABLE IF NOT EXISTS document_schema._attributes(_id serial, key_name text NOT NULL, key_type text NOT NULL);

-- Extraction Functions

CREATE OR REPLACE FUNCTION
document_get(text, cstring)
RETURNS anyelement
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION
document_put(text, cstring)
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION
document_delete(text, cstring)
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;