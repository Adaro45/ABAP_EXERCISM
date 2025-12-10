"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language:
https://en.wikipedia.org/wiki/Guido_van_Rossum

This is a module docstring, used to describe the functionality
of a module and its functions and/or classes.
"""


#TODO: define your EXPECTED_BAKE_TIME (required) and PREPARATION_TIME (optional) constants below.
EXPECTED_BAKE_TIME = 40
PREPARATION_TIME = 2

#TODO: Remove 'pass' and complete the 'bake_time_remaining()' function below.
def bake_time_remaining(elapsed_bake_time):
    """Calculate the preparation time in minutes.

    :param elapsed_bake_time: int - the actual minutes the lasagna has been in the oven.
    :return: int elapsed_bake_time - EXPECTED_BAKE_TIME (in minutes) cooking.

    This function takes one integer representing the actual minutes the lasagna has been in the oven 
    and calculates how many minutes the lasagna still needs to bake.
    """
    return EXPECTED_BAKE_TIME - elapsed_bake_time     

#TODO: Define the 'preparation_time_in_minutes()' function below.
def preparation_time_in_minutes(number_of_layers ):
    """Calculate the preparation time in minutes.

    :param number_of_layers: int - the number of layers in the lasagna.
    :return: int number_of_layers * PREPARATION_TIME (in minutes) preparing and cooking.

    This function takes one integer representing the number of lasagna layers 
    and calculates the total elapsed minutes spent cooking the lasagna.
    """  
    return number_of_layers * PREPARATION_TIME
    
#TODO: define the 'elapsed_time_in_minutes()' function below.
def elapsed_time_in_minutes(number_of_layers,elapsed_bake_time):
    """Calculate the elapsed cooking time.

    :param number_of_layers: int - the number of layers in the lasagna.
    :param elapsed_bake_time: int - elapsed cooking time.
    :return: (number_of_layers * PREPARATION_TIME) + elapsed_bake_time (in minutes) preparing and cooking.

    This function takes two integers representing the number of lasagna layers and the
    time already spent baking and calculates the total elapsed minutes spent cooking the
    lasagna.
    """    
    return (number_of_layers * PREPARATION_TIME) + elapsed_bake_time



# TODO: Remember to go back and add docstrings to all your functions
#  (you can copy and then alter the one from bake_time_remaining.)
