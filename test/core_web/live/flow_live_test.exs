defmodule CoreWeb.FlowLiveTest do
  use CoreWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders flow page with React Flow component", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/flow")

    # Проверяем, что страница загружается
    assert html =~ "React Flow Demo"

    # Проверяем, что React компонент Flow рендерится
    assert html =~ "data-name=\"Flow\""
    assert html =~ "phx-hook=\"ReactHook\""
  end

  test "flow page has correct structure", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/flow")

    # Проверяем, что страница имеет правильную структуру
    assert has_element?(view, "h1", "React Flow Demo")
  end

  test "flow page renders React component container", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/flow")

    # Проверяем, что контейнер для React компонента присутствует
    assert html =~ "data-name=\"Flow\""
    assert html =~ "data-props=\"{}\""
    assert html =~ "data-slots=\"{}\""
  end

  test "flow page loads without errors", %{conn: conn} do
    # Проверяем, что страница загружается без ошибок
    assert {:ok, _view, _html} = live(conn, ~p"/flow")
  end

  test "flow page has React Flow specific attributes", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/flow")

    # Проверяем атрибуты, специфичные для React Flow
    assert html =~ "data-ssr"
    assert html =~ "phx-update=\"ignore\""
  end

  test "flow page React component has correct configuration", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/flow")

    # Проверяем конфигурацию React компонента
    assert html =~ "data-name=\"Flow\""
    assert html =~ "data-props=\"{}\""
    assert html =~ "data-slots=\"{}\""
    assert html =~ "phx-hook=\"ReactHook\""
    assert html =~ "phx-update=\"ignore\""
  end
end
