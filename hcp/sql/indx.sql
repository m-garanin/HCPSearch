CREATE INDEX idx_npi ON npidatas 
       USING btree (npi varchar_pattern_ops);
CREATE INDEX idx_first_name ON npidatas 
       USING btree (first_name varchar_pattern_ops);
CREATE INDEX idx_last_name_legal_name ON npidatas 
       USING btree (last_name_legal_name varchar_pattern_ops);
CREATE INDEX idx_healthcare_taxonomy_code_1 ON npidatas 
       USING btree (healthcare_taxonomy_code_1 varchar_pattern_ops);

CREATE INDEX idx_business_mailing_address_postal_code ON npidatas 
       USING btree ( business_mailing_address_postal_code varchar_pattern_ops);
CREATE INDEX idx_business_mailing_address_state_name ON npidatas 
       USING btree (business_mailing_address_state_name varchar_pattern_ops);

CREATE INDEX idx_organization_name_legal_business_name ON npidatas 
       USING btree (organization_name_legal_business_name varchar_pattern_ops);

