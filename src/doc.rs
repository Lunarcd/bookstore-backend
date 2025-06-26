use std::sync::Arc;

use axum::Router;
use utoipa::{
    Modify, OpenApi,
    openapi::security::{ApiKey, ApiKeyValue, SecurityScheme},
};
use utoipa_swagger_ui::SwaggerUi;

use super::{controller, state::ApiState};

struct SecurityAddon;

impl Modify for SecurityAddon {
    fn modify(&self, openapi: &mut utoipa::openapi::OpenApi) {
        if let Some(components) = openapi.components.as_mut() {
            components.add_security_scheme(
                "jwt_token",
                SecurityScheme::ApiKey(ApiKey::Cookie(ApiKeyValue::new("token"))),
            )
        }
    }
}

#[derive(OpenApi)]
#[openapi(
    paths(
        controller::ping,
    ),
    modifiers(&SecurityAddon),
)]
struct ApiDoc;

pub fn build() -> Router<Arc<ApiState>> {
    SwaggerUi::new("/swagger-ui")
        .url("/api-docs/openapi.json", ApiDoc::openapi())
        .into()
}
