module FlashHelper

  def danger(message)
    set_flash :danger,  message
  end

  def notice(message)
    set_flash :notice,  message
  end

  def success(message)
    set_flash :success, message
  end

  def warning(message)
    set_flash :warning, message
  end


  private

    def set_flash(key, message)
      flash[key.to_sym] = get_message(message)
    end

    def get_message(message)
      # Either finds the message reference,
      # or returns the message itself
      reference = message.to_sym
      messages.fetch(reference) { message.to_s }
    end

    def messages
      {
        welcome: "Welcome to the DataCommon!",
        no_user: "No user with that username could be found.",
        profile_updated: "Your profile was updated.",
        already_activated: "It looks like your account is already activated. Please get in touch if you think this is an error.",
        resent_activation_email: "Sent! Check your email for the activation link.",
        unexpected_error: "An unexpected error occurred when we tried to send the email. If you try again and it still doesn't work, please get in touch with us for help.",
        only_owner_may_edit: "You may only edit your own profile. If you were trying to edit your profile, please sign in first.",

        visual_sign_in_first: "Please sign in before you create a visualization.",
        visual_only_owner_may_view: "This visualization has been made private. Only its owner may view it.",
        visual_only_owner_may_edit: "Is this your visualization? Please log in to edit it.",
        visual_not_found: "Sorry! According to our records, no visualization with that ID exists."
      }
    end

end