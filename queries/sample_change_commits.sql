select
general.bq_change(message) > 0 as change
, count(*)
from
general.enhanced_commits
group by
change
order by
change
;



# Basic labeling function hits
Select
distinct
repo_name
, commit
, subject
, message
, is_corrective
, is_adaptive
, is_perfective
, is_refactor
, '' as corrective
, '' as adaptive
, '' as perfective
, '' as refactor
, '' as change
, '' as comment
, '' as justification
, 'change_hits_batch_1' as batch
from
general.enhanced_commits
where
general.bq_change(message) > 0
#and length(message) < 300
and
substr(commit, 9,1) = '4'
and
substr(commit, 5,1) = '5'
limit 100
;

# Possible false negatives
Select
distinct
repo_name
, commit
, subject
, message
, is_corrective
, is_adaptive
, is_perfective
, is_refactor
, '' as corrective
, '' as adaptive
, '' as perfective
, '' as refactor
, '' as change
, '' as comment
, '' as justification
, 'possibile_fn' as batch
from
general.enhanced_commits
where
general.bq_change(message) = 0
and regexp_contains(lower(message), '(change|re(-| )?work(ed|s|ing)?|replac(e|es|ed|ing))')
and not regexp_contains(lower(message), 'change.id:')

#and length(message) < 300
and
substr(commit, 3,1) = '7'
and
substr(commit, 8,1) = '8'
limit 100
;


# Random samples
Select
distinct
repo_name
, commit
, subject
, message
, is_corrective
, is_adaptive
, is_perfective
, is_refactor
, '' as corrective
, '' as adaptive
, '' as perfective
, '' as refactor
, '' as change
, '' as comment
, '' as justification
, 'random_batch_1' as batch
from
general.enhanced_commits
where
substr(commit, 9,1) = 'c'
and
substr(commit, 5,1) = 'b'
limit 100
;