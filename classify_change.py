from os.path import join
import pandas as pd

# For debug
from re import findall

from model_evaluation import evaluate_regex_results, evaluate_regex_results_on_df
from labeling_util import get_false_positives, get_false_negatives
from language_utils import SCHEMA_NAME, file_scheme, term_seperator, build_sepereted_term, negation_terms, modals\
    , regex_to_big_query, generate_bq_function, match

DATA_PATH = '/Users/idan/src/commit-classification/data/'

#TODO - add change synonyms - replace, update adjast, switch, adapt, modify, fit, alter, substitute
NEAR_ENOUGH = '[\S\s]{1,40}'
change_verb = '(chang(e|ed|es)|changing)'
change_terms = [change_verb, 're(-|\s)?work(ed|s|ing)?', 'bring' + NEAR_ENOUGH + 'in accordance'
    , change_verb + NEAR_ENOUGH + 'back' , '(\-)?codechange(:)?']

changeable_entities = ['comment', 'whitespace', 'indentation', 'style', 'version(\snumber|\snum)?', 'cosmetic'
, 'format(ing)?', 'documentation', 'doc(s)?', 'FAQ', 'copyright(s)?', 'log', 'makefile', 'spacing', 'name(s)?', 'signature'
, 'row(s)?', 'record(s)?', 'access\smodifier(s)?', 'function\stype', 'dictionary', 'grammar', 'line\sending(s)?'
, 'detection', 'code\sreview', '(argument|parameter)(s)?\sorder', 'run(-)?time', 'detector(s)?', 'help(-)?text(s)?'
, 'help']

other_changes_terms = [
 change_verb + NEAR_ENOUGH + '\s(to|into)' # Exclude change X to Y, usually a refactor and not a change request
, 'to\schange'
, 'update\schanges' # refers to CHANGES file
, 'changelog', 'change\.log', 'change-log' # A common term change.log. including the word change
, 'revert' + NEAR_ENOUGH + 'change(s)?' # Not a new change
, "(" + "|".join(changeable_entities) +')\schange(s)?' # Not a change request
, change_verb + NEAR_ENOUGH + "(" + "|".join(changeable_entities) +')'# Not a change request
, '(previous|last|prev|prev\.|earlier|prior|future)\schange(s)?' # Not a new change
, '(revert|undo)' + NEAR_ENOUGH + 'change(s)?' # Not a new change
, 'redo' + NEAR_ENOUGH + 'change(s)?' # Not a new change
, 'adapt(ed|s|ing)?' + NEAR_ENOUGH + 'change(s)?' # Not a new change
, 'match(ed|s|ing)?' + NEAR_ENOUGH + 'change(s)?' # Not a new change
, change_verb + NEAR_ENOUGH + file_scheme
, '[-_]' + change_verb, change_verb + '[-_]' # Change as part of variable
, 'for\s' + change_verb # General term
, 'password\s' + change_verb, change_verb + NEAR_ENOUGH + 'password'
, '(no|not|without)\s' + change_verb + 'functionality' # A negatively declared refactor
, 'handl(e|es|ed|ing)\s' + change_verb # Change is the subject
, '(mistakenly|by mistake|unintended|not intended|correctly)\s' + NEAR_ENOUGH + change_verb
, change_verb + NEAR_ENOUGH + 'debug(ing)?' # A change for the developer, not a change request
, 'change(\s)?(:|#)(\s)?\d+'
, 'support(s|ed|ing)?' + NEAR_ENOUGH + change_verb
, 'fix(es|ed|ing)?' + NEAR_ENOUGH + change_verb
,  change_verb + NEAR_ENOUGH + 'fix(es|ed|ing)?'
, 'avoid(s|ed|ing)?' + NEAR_ENOUGH + change_verb
, 'merg(e|es|ed|ing)?' + NEAR_ENOUGH + change_verb
, 'prepar(e|es|ed|ing)?' + NEAR_ENOUGH + change_verb
, 'verif(y|ies|ied|ing)' + NEAR_ENOUGH + change_verb
, 'what\schanges\swere\sproposed' # Spark - ## What changes were proposed in this pull request?
, 'changes in this commit(:)?' # Common phrase
]

non_change_context = ['if', 'so that', 'being\sable'] + negation_terms + modals


def build_change_regex():

    return build_sepereted_term(change_terms) # "(%s)" % ("|".join(change_terms))


def build_other_change_regex():

    return build_sepereted_term(other_changes_terms)


def build_other_context_change_regex():

    return build_sepereted_term(non_change_context) + NEAR_ENOUGH + build_sepereted_term(change_terms)


def is_change(commit_text):


    t1 = match(commit_text, build_change_regex())
    t2 = match(commit_text, build_other_change_regex())
    t3 = match(commit_text, build_other_context_change_regex())


    return (match(commit_text, build_change_regex())
             - match(commit_text, build_other_change_regex())
            - match(commit_text, build_other_context_change_regex())
            ) > 0



def change_to_bq():

    print("# Change")
    print( "# Change :build_change_regex()")
    print( regex_to_big_query(build_change_regex()))
    print( "# Change :build_other_change()")
    print( "-")
    print( regex_to_big_query(build_other_change_regex()))
    print( "# Change :build_other_context_change_regex()")
    print( "-")
    print( regex_to_big_query(build_other_context_change_regex()))

def print_bq_functions():
    print()
    generate_bq_function('{schema}.bq_change'.format(schema=SCHEMA_NAME), change_to_bq)

def change_evaluation():
    classification_column = 'change_pred'
    concept_column='change'
    cms = evaluate_regex_results(join(DATA_PATH, 'change_samples.csv')
                           , classification_column=classification_column
                           , classification_function=is_change
                           , concept_column=concept_column
                           )
    print(cms)

    df = pd.read_csv(join(DATA_PATH, 'change_samples.csv'))

    pd.options.display.max_rows = 200
    pd.options.display.max_columns = 200

    print("False positives")
    print(get_false_positives(df
                              , classifier_column=classification_column
                              , concept_column=concept_column))
    print("False negatives")
    print(get_false_negatives(df
                              , classifier_column=classification_column
                              , concept_column=concept_column))


def change_evaluation_on_batch(batch_name):
    classification_column = 'change_pred'
    concept_column='change'
    df = pd.read_csv(join(DATA_PATH, 'change_samples.csv'))
    df = df[df.batch == batch_name]

    cms = evaluate_regex_results_on_df(df
                           , classification_column=classification_column
                           , classification_function=is_change
                           , concept_column=concept_column
                           )
    print(cms)


    pd.options.display.max_rows = 200
    pd.options.display.max_columns = 200

    observed = [
        '28b257dc4c8ba15a4045b13884054d8e626063cd'
        , 'd7a95d15492c2fe33ba15cc176dd27b90a494211'
        , '46415bb248aa2b2744ae1ef715ac7b0f46cc014d'
        , '1828546341fb876104db14dd5a41a77084d85041'
        , 'b7a4506c47df462d67f9c15da8a047568d2385b4'
        , '32b7595c4771b193b5869f5a97f935e404f16e30'
        , '18c459484a63d8300ad6a3b359f80a801ea6a1bc'
        , 'b5045f4a4358927cdeaf6b3e3459b3d89b0f1fcf'
        , '861e51a244d25e645538c9657a18ad04797b924a'
        , 'd84d5b094a5ed7223cff284fd6f1cb20126c5f1d'
        , '1ba7577a46be45d835560663ba375729c628d981'
        , '88c35ed04491903ee0f01b96a08e322f71a65339'
        , '165c5da44a672392f5055f20c4376df831077b01'
        , 'faf85529449e0fb4f345d93dd6a7b9a5d481e9fb'
        , 'e5c358514c60260f8a0b56fb9ad5eb0a91f13681'
        , 'a965545049d652b48620882c8952a0ebda497809'
        , '5944556e4cc545bc8ab6e3efd46232e854509d1d'
        , 'e25359c94de9bf04b214b24fb034e4e5f3040421'
        , '5e725a3546d0687452111e732542091ebb60c9b2'
        , '269954e542328f014fc07fbb0a986192f7a1cced'
        , '7c655cf643671126b4c3aa3b574b8ac5efbd9bd3'
        , '331d59694076926823225dbe032a8a8decb572ea'
        , '90515ba54eedc07949206451c243d1e2148a4e43'
        , '85945c6d4f46d08027f5b2dad21031a140ef1e14'
        , '85945c6d4f46d08027f5b2dad21031a140ef1e14'
    ]
    print("False positives")
    print(get_false_positives(df[~df.commit.isin(observed)]
                              , classifier_column=classification_column
                              , concept_column=concept_column))
    print("False negatives")
    print(get_false_negatives(df
                              , classifier_column=classification_column
                              , concept_column=concept_column))


if __name__ == '__main__':
    print_bq_functions()



    text = """Markup changes. Addition of code tags.

git-svn-id: https://svn.apache.org/repos/asf/jmeter/trunk@1714326 13f79535-47bb-0310-9956-ffa450edef68

Former-commit-id: d619a26b9c07f7928aeb8c29c1942326e39e511f
"""

    print("Text: ", text)
    print("Is change", is_change(text))
    print("Match build_change_regex", match(text, build_change_regex()))
    print("Match  build_other_change_regex", match(text, build_other_change_regex()))
    print("find", findall(text.lower(), build_other_change_regex()))
    print("Match  build_other_context_change_regex", match(text, build_other_context_change_regex()))
    print(build_other_change_regex())


    #change_evaluation()

    #change_evaluation_on_batch(batch_name='change_hits_batch_1')
    change_evaluation_on_batch(batch_name='possibile_fn')
    #change_evaluation_on_batch(batch_name='random_batch_1')

