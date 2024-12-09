defmodule ElixirGistWeb.UserForgotPasswordLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Accounts

  def render(assigns) do
    ~H"""
    <div class="em-gradient flex flex-col items-center justify-center">
      <h1 class="font-brand font-bold text-3xl text-white py-2">
        Մոռացե՞լ եք Ձեր գաղտնաբառը
      </h1>
      <h3 class="font-brand font-bold text-l text-white">
        Գաղտնաբառի վերականգնման հրահանգների հղումը կուղարկենք Ձեր էլ․ հասցեին
      </h3>
    </div>
    <div class="mx-auto max-w-sm">
      <.form for={@form} id="reset_password_form" phx-submit="send_email">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <div class="pt-6">
          <.button phx-disable-with="Sending..." class="create_button w-full">
            Ուղարկել հրահանգների հղումը
          </.button>
        </div>
      </.form>
      <p class="text-center text-l font-brand font-bold text-white mt-4">
        <.link href={~p"/users/register"} class="text-emLavender-dark hover:underline">
          Գրանցում
        </.link>
        | <.link href={~p"/users/log_in"} class="text-emLavender-dark hover:underline">Մուտք</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/users/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/users/log_in")}
  end
end
