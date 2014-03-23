%%% @author os <os@macbook-air-os>
%%% @copyright (C) 2014, os
%%% @doc
%%%
%%% @end
%%% Created : 22 Mar 2014 by os <os@macbook-air-os>

-module(hcp_search_controller, [Req]).
-export([index/2, doctors/2, orgs/2]).

-define(LIMIT, 200).
-define(DOC_TYPE, "1").
-define(ORG_TYPE, "2").
-define(ORDER_BY, npi).


index('GET', []) ->
    DForm = boss_form:new(search_doctor_form, []),
    OForm = boss_form:new(search_org_form, []),    
    {ok, [{search_doctor_form, DForm}, {search_org_form, OForm}]}.


doctors('GET',[]) ->
    {redirect, "index"};  
doctors('POST',[]) ->
    PostParams = Req:post_params(),
    DForm = boss_form:new(search_doctor_form, PostParams),
    OForm = boss_form:new(search_org_form, []),    
    {ok, CleanedData} = boss_form:validate(DForm, PostParams),
    Conditions = make_conditions(CleanedData),
    NpiDatas = boss_db:find(npidata, 
			    [{entity_type_code, ?DOC_TYPE}] ++ Conditions, 
			    [{order_by, ?ORDER_BY},
			     {limit, ?LIMIT}]),
    {ok, [{npidatas, NpiDatas},
	  {fdata, CleanedData},
	  {need_details, (length(NpiDatas) == ?LIMIT)},
	  {search_doctor_form, DForm}, 
	  {search_org_form, OForm}
	 ]}.


orgs('GET',[]) ->
    {redirect, "index"};
orgs('POST',[]) ->
    PostParams = Req:post_params(),
    DForm = boss_form:new(search_doctor_form, []),
    OForm = boss_form:new(search_org_form, PostParams),    
    {ok, CleanedData} = boss_form:validate(OForm, PostParams),
    Conditions = make_conditions(CleanedData),
    NpiDatas = boss_db:find(npidata,
			    [{entity_type_code, ?ORG_TYPE}] ++ Conditions, 
			    [{order_by, ?ORDER_BY},
			     {limit, ?LIMIT}]), 
    {ok, [{npidatas, NpiDatas},
	  {fdata, CleanedData},
	  {need_details, (length(NpiDatas) == ?LIMIT)},
	  {search_doctor_form, DForm}, 
	  {search_org_form, OForm}
	 ]}.


%%--------------------------------------------------------------------
%% @doc
%% @spec make_conditions(Proplist) -> BossDBConditions 
%% @end
%%--------------------------------------------------------------------
make_conditions(Data) ->
    make_conditions(Data,[]).

make_conditions([], Res) -> Res;
make_conditions([{Key, undefined}|Tail], Res) -> 
    make_conditions(Tail, Res);
make_conditions([{Key, Value}|Tail], Res) ->
    NewRes = [{Key, 'matches', "*^" ++ Value}] ++ Res,
    make_conditions(Tail, NewRes).

