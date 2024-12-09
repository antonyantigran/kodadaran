defmodule ElixirGistWeb.UserLoginLive do
  use ElixirGistWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="em-gradient flex flex-col items-center justify-center">
      <h1 class="font-brand font-bold text-3xl text-white py-2">
        Մուտք հաշիվ
      </h1>
      <h3 class="font-brand font-bold text-l text-white">
        Չունե՞ք հաշիվ։
        <.link
          navigate={~p"/users/register"}
          class="font-semibold text-brand hover:underline text-emLavender-dark"
        >
          Ստեղծեք
        </.link>
        Ձեր հաշիվը հիմա
      </h3>
    </div>
    <div class="mx-auto max-w-sm">
      <.form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.input field={@form[:email]} type="email" placeholder="Էլ․ հասցե" required />
        <.input field={@form[:password]} type="password" placeholder="Գաղտնաբառ" required />
        <div class="flex item-scenter justify-between py-4">
          <.input field={@form[:remember_me]} type="checkbox" label="Հիշել ինձ" />
          <.link
            href={~p"/users/reset_password"}
            class="text-m text_brand text-emDark-light font-semibold hover:underline"
          >
            Մոռացե՞լ եք գաղտնաբառը
          </.link>
        </div>
        <.button phx-disable-with="Մուտք..." class="create_button w-full">
          Մտնել <span aria-hidden="true">→</span>
        </.button>
      </.form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
