"""Functions for tracking poker hands and assorted card tasks.

Python list documentation: https://docs.python.org/3/tutorial/datastructures.html
"""


def get_rounds(number):
    """Create a list containing the current and next two round numbers.

    :param number: int - current round number.
    :return: list - current round and the two that follow.
    """

    return [number,number+1, number+2]


def concatenate_rounds(rounds_1, rounds_2):
    """Concatenate two lists of round numbers.

    :param rounds_1: list - first rounds played.
    :param rounds_2: list - second set of rounds played.
    :return: list - all rounds played.
    """

    return rounds_1+rounds_2


def list_contains_round(rounds, number):
    """Check if the list of rounds contains the specified number.

    :param rounds: list - rounds played.
    :param number: int - round number.
    :return: bool - was the round played?
    """

    return number in rounds


def card_average(hand):
    """Calculate and returns the average card value from the list.

    :param hand: list - cards in hand.
    :return: float - average value of the cards in the hand.
    """
    avg = 0
    for card in range(len(hand)):
        avg += hand[card]
    avg= avg/len(hand)
    return float(avg)

def approx_average_is_average(hand):
    """Return if the (average of first and last card values) OR ('middle' card) == calculated average.

    :param hand: list - cards in hand.
    :return: bool - does one of the approximate averages equal the `true average`?
    """
    index= len(hand)-1
    median = hand[int(index/2)]
    firs_and_last = (hand[0]+hand[-1])/2
    return median == card_average(hand) or card_average(hand) == firs_and_last

def average_even_is_average_odd(hand):
    """Return if the (average of even indexed card values) == (average of odd indexed card values).

    :param hand: list - cards in hand.
    :return: bool - are even and odd averages equal?
    """
    even = 0
    even_times = 0
    odd = 0
    odd_times = 0
    for index, card in enumerate(hand):
        if index % 2 == 0:
            even += card
            even_times += 1
        else:
            odd += card
            odd_times += 1
    even = even / even_times if even_times > 0 else 0
    odd = odd / odd_times if odd_times > 0 else 0

    return even == odd
    


def maybe_double_last(hand):
    """Multiply a Jack card value in the last index position by 2.

    :param hand: list - cards in hand.
    :return: list - hand with Jacks (if present) value doubled.
    """
    double = hand.copy()
    if hand[-1] == 11:
        double[-1] = hand[-1]*2
    
    
    return double
