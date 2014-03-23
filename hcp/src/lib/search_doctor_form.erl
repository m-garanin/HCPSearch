%%% @author os <os@macbook-air-os>
%%% @copyright (C) 2014, os
%%% @doc
%%%
%%% @end
%%% Created : 23 Mar 2014 by os <os@macbook-air-os>

-module(search_doctor_form, [InitialData, Errors]).
-compile(export_all).
-include("states.hrl").

form_fields()->
    [
     {first_name, [{type, char_field},
                 {label, "Doctor's First Name"},
                 {required, false}
                 ]},

     {last_name_legal_name, [{type, char_field},
                 {label, "Doctor's Last Name"},
                 {required, false}
                 ]},

     {npi, [{type, char_field},
                 {label, "NPI"},
                 {required, false}
                 ]},

     {healthcare_taxonomy_code_1, [{type, char_field},
                 {label, "Taxonomy"},
                 {required, false}
                 ]},
     
     
     {business_mailing_address_postal_code, [{type, char_field},
                 {label, "Zip Code"},
                 {required, false}
                 ]},
     
     {business_mailing_address_state_name, [{type, choice_field},
                 {label, "State"},
                 {required, false},
	         {choices, ?STATES}
                 ]}

    ].



%% Proxies
data() ->
    InitialData.

errors() ->
    Errors.

fields() ->
    boss_form:fields(form_fields(), InitialData).

as_table() ->
    boss_form:as_table(form_fields(), InitialData, Errors).


