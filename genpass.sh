#!/bin/bash

# Generate a random 12-character password meeting complexity requirements
generate_password() {
    # Character sets
    digits='0123456789'
    lower='abcdefghijklmnopqrstuvwxyz'
    upper='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    special='!@#$%^&*()_+-=[]{}|;:,.<>?'
    
    # Ensure at least one character from each set
    password=$( \
        echo -n "${digits:$((RANDOM%${#digits})):1}" \
        "${lower:$((RANDOM%${#lower})):1}" \
        "${upper:$((RANDOM%${#upper})):1}" \
        "${special:$((RANDOM%${#special})):1}" \
        | tr -d ' ' \
    )
    
    # Fill remaining 8 characters with random mix
    all_chars="${digits}${lower}${upper}${special}"
    password+=$( \
        head /dev/urandom | tr -dc "$all_chars" | head -c 8 \
    )
    
    # Shuffle the characters
    echo "$password" | fold -w1 | shuf | tr -d '\n'
    echo
}

# Main execution
generate_password
