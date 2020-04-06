# Run in Starndad sql
CREATE OR REPLACE FUNCTION
ccp.bq_non_positive_linguistic_refactor_removal
 (message string)
 RETURNS int64
AS (
# Model language based on commit: 5cd4738202154452854991b2714ce49459316371
# Refactor :build_non_positive_linguistic(build_sepereted_term(removal))
(LENGTH(REGEXP_REPLACE(lower(message),'(((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(can|could|ha(ve|s|d)|may|might|must|need|ought|shall|should|will|would))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|))|((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(aren\'t|didn\'t|don\'t|doesn\'t|isn\'t|lack|n\'t|never|no|nobody|none|not|nothing|weren\'t|without|won\'t))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|))|((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(for(get|gets|got|geting)|allow(s|ed|ing)?))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|))|((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(change( |-)?log|comment(s)?|copy( |-)?right(s)?|doc(s)?|documentation|explanation(s)?|man( |-)?page(s)?|manual|note(s)?|readme(.md)?|translation(s)?|java( |-)?doc(s)?|java( |-)?documentation|example(s)?|diagram(s)?|guide(s)?|icon(s)?|doc( |-)?string(s)?|tutorials(s)?|help|man|doc( |-)?string(s)?|desc(ription)?(s)?|copy( |-)?right(s)?|explanation(s)?|release notes))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)))', '@'))-LENGTH(REGEXP_REPLACE(lower(message),'(((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(can|could|ha(ve|s|d)|may|might|must|need|ought|shall|should|will|would))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|))|((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(aren\'t|didn\'t|don\'t|doesn\'t|isn\'t|lack|n\'t|never|no|nobody|none|not|nothing|weren\'t|without|won\'t))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|))|((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(for(get|gets|got|geting)|allow(s|ed|ing)?))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|))|((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(change( |-)?log|comment(s)?|copy( |-)?right(s)?|doc(s)?|documentation|explanation(s)?|man( |-)?page(s)?|manual|note(s)?|readme(.md)?|translation(s)?|java( |-)?doc(s)?|java( |-)?documentation|example(s)?|diagram(s)?|guide(s)?|icon(s)?|doc( |-)?string(s)?|tutorials(s)?|help|man|doc( |-)?string(s)?|desc(ription)?(s)?|copy( |-)?right(s)?|explanation(s)?|release notes))[\\s\\S]{0,10}((\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)(add(s|ed|ing)?[\\s\\S]{1,50}helper(s)?|us(e|es|ed|ing)[\\s\\S]{1,50}instead|split(s|ing)?[\\s\\S]{1,50}into|break(s|ing)?[\\s\\S]{1,50}into|separat(e|e s|ed|ing)[\\s\\S]{1,50}into|replac(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|remov(e|es|ed|ing)[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|kill(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|drop(s|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented)|mov(e|es|ed|ing)?[\\s\\S]{1,50}(unnecessary|unneeded|unused|(not|never|no longer) used|no longer needed|redundant|useless|duplicate(d)?|deprecated|obsolete(d)?|commented))(\\s|\\.|\\?|\\!|\\[|\\]|\\(|\\)|\\:|^|$|\\,|\'|"|/|#|\\$|\\%|&|\\*|\\+|=|`|;|<|>|@|~|{|}|\\|)))', '')))
 )