use postgres_types::{FromSql, ToSql};
use serde::{Deserialize, Serialize};
use utoipa::ToSchema;

#[derive(Debug, Clone, Copy, PartialEq, Eq, ToSql, FromSql, Serialize, Deserialize, ToSchema)]
#[serde(rename_all = "snake_case")]
#[postgres(name = "role", rename_all = "snake_case")]
pub enum Role {
    Member,
    Staff,
    Admin,
}